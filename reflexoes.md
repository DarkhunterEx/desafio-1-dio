# Reflexões sobre o desafio

Neste desafio, usei o Kali Linux para testar autenticação em FTP, SMB e no formulário do DVWA. Reuni os comandos e as capturas para acompanhar o que aconteceu em cada tentativa, incluindo os erros.

## O que os testes mostraram

No FTP, o Medusa encontrou a combinação `msfadmin` / `msfadmin`. A captura da conexão manual mostra o login aceito, o que permite conferir o resultado por outra etapa do teste. Também ficou registrada uma tentativa com a mensagem `530 Login incorrect`.

No SMB, a preparação incluiu os comandos de enumeração com enum4linux descritos nas anotações. Usei o Medusa para testar as credenciais e o smbclient para consultar os compartilhamentos. Os registros estão em [Testes realizados](documentacao/tests.md), junto com as imagens correspondentes.

O teste web exigiu mais cuidado na leitura da saída. Hydra e Medusa indicaram `admin` / `password`, mas o Medusa também exibiu `WARNING: Invalid method: form-data`. Esse aviso precisa ser investigado antes de considerar o comando validado. A mensagem de sucesso, sozinha, não resolve o problema de configuração mostrado na mesma captura.

## A diferença entre os IPs

As capturas de FTP e SMB mostram `192.168.56.101` como alvo. No teste web, o endereço usado foi `127.0.0.1`. Já a variável `TARGET` dos scripts define `192.168.56.102` para FTP e SMB e `192.168.56.103` para o DVWA. O script de FTP ainda abre a conexão manual em `192.168.56.101` ao final.

Esses endereços precisam ser conferidos antes de outra execução. Ao adaptar os scripts, é necessário ajustar tanto a variável do alvo quanto os comandos que usam um endereço escrito diretamente. Na documentação, mantive cada resultado associado ao IP que aparece na captura.

## Cuidados com os parâmetros

Ao adaptar um comando, é preciso conferir a função das opções na ferramenta usada:

- No Medusa, `-t` define quantos logins serão testados ao mesmo tempo, enquanto `-T` define quantos hosts serão testados em paralelo. Portanto, `-T 50` não cria uma pausa de 50 segundos entre tentativas. Essa distinção está na [documentação do Medusa](https://www.kali.org/tools/medusa/).
- A opção `-h` indica o alvo no Medusa. No Hydra, ela abre a ajuda; o alvo aparece como argumento do comando. A sintaxe está descrita na [documentação do Hydra](https://www.kali.org/tools/hydra/).
- O comando do Hydra usa `http-get-form`, que envia os parâmetros por GET. O módulo `web-form` do Medusa aceita GET e POST, conforme a [documentação do módulo](https://jmk-foofus.github.io/medusa/medusa-web-form.html). As opções de uma ferramenta não devem ser copiadas para a outra sem conferir a sintaxe.

A sintaxe do cabeçalho e do parâmetro `form-data` ainda precisa ser conferida em outra execução. O aviso registrado na captura continua sendo um ponto a resolver no teste com Medusa.

## O que levo desta prática

Registrar o comando completo ajuda a entender um resultado depois. O IP, o caminho das listas, o módulo escolhido e a resposta do serviço fazem diferença nessa análise. No FTP, por exemplo, a captura da conexão manual complementa a saída do Medusa. No teste web, o aviso exibido junto ao resultado mostra por que é necessário conferir toda a saída.

As listas de usuários e senhas também precisam estar identificadas no registro. Assim, fica claro quais combinações foram testadas, sem tratar o tamanho da lista como medida de qualidade do teste.

## Próximos passos

- Conferir os IPs e os caminhos das listas antes de repetir os testes no laboratório.
- Revisar a configuração do formulário web e registrar a validação manual das credenciais indicadas.
- Salvar os comandos e as saídas junto das capturas para facilitar a comparação entre as execuções.
- Explorar outros módulos, como SSH, mantendo os testes no ambiente de estudo autorizado.
