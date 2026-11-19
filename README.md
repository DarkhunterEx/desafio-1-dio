# Desafio DIO: força bruta com Kali Linux e Medusa

Neste desafio, usei o Kali Linux para testar a autenticação em serviços FTP, SMB e no formulário web do DVWA. O objetivo foi entender como as ferramentas fazem as tentativas de login, conferir os acessos encontrados e relacionar os resultados com medidas de proteção.

O projeto foi desenvolvido em um laboratório com máquinas virtuais, usando VirtualBox, Metasploitable 2 e DVWA. Reuni neste repositório os comandos, as capturas de tela e as observações sobre o que funcionou e os problemas encontrados. Os testes se limitam a esse ambiente de estudo e devem ser repetidos apenas em sistemas próprios ou com autorização.

## Ambiente utilizado

As ferramentas usadas foram Medusa, Hydra, enum4linux e smbclient. O Medusa foi usado nas tentativas de autenticação; o Hydra, no formulário web; o enum4linux, na etapa de enumeração descrita nas anotações; e o smbclient, na consulta aos compartilhamentos SMB.

Os endereços que aparecem nas capturas são:

| Serviço | Endereço registrado |
|---|---|
| FTP e SMB do Metasploitable 2 | `192.168.56.101` |
| DVWA | `127.0.0.1`, acessado localmente |

A configuração da rede host-only está descrita em [Configuração do ambiente](documentacao/setup-ambiente.md). Os scripts têm endereços diferentes dos que aparecem nas capturas; por isso, é preciso conferir o alvo, os caminhos das listas e a sessão do DVWA antes de reutilizá-los.

## Testes e resultados

### FTP

Usei o módulo FTP do Medusa para testar combinações de usuários e senhas. A ferramenta encontrou `msfadmin` como usuário e senha. Depois, fiz a conexão pelo cliente FTP e confirmei o login com a resposta `230 Login successful`.

Também registrei uma tentativa que recebeu `530 Login incorrect`. Essa captura mostra uma falha de autenticação; o servidor chegou a aceitar a conexão.

### SMB

O teste com o módulo `smbnt` do Medusa também encontrou a combinação `msfadmin` / `msfadmin`. Em seguida, consultei os compartilhamentos com o smbclient. A captura mostra a listagem e, em uma segunda tentativa, a mensagem `NT_STATUS_LOGON_FAILURE`.

A imagem chamada `print smb do enu4linux.png` contém a execução do Medusa. O nome do arquivo foi mantido, mas a descrição da evidência corresponde ao conteúdo da tela.

### Formulário web do DVWA

No DVWA, usei Medusa e Hydra com o usuário `admin`. O Hydra informou a senha `password`. O Medusa apresentou a mesma combinação, junto do aviso `WARNING: Invalid method: form-data`. Esse aviso precisa ser considerado antes de tratar a execução do Medusa como validada.

Também há uma captura de uma entrada de injeção SQL no campo de usuário da página **Brute Force**. A tela mostra a mensagem de boas-vindas após essa entrada. O procedimento e o limite do que a imagem permite concluir estão descritos em [Testes realizados](documentacao/tests.md).

## Evidências

| Captura | Conteúdo |
|---|---|
| [Teste FTP com Medusa](images/print%20do%20ftp%20medusa.png) | Combinação `msfadmin` / `msfadmin` identificada |
| [Conexão FTP](images/resultado%20ftp%20conectado.png) | Login confirmado no cliente FTP |
| [Teste SMB com Medusa](images/print%20smb%20do%20enu4linux.png) | Resultado do módulo `smbnt` |
| [Consulta SMB](images/resultado%20do%20smb%20.png) | Compartilhamentos listados e uma tentativa posterior com falha |
| [Medusa e Hydra no DVWA](images/print%20brute%20force%20hydra%20e%20medusa.png) | Saídas das duas ferramentas no formulário web |
| [Entrada de SQL no formulário](images/print%20sql%20injection.png) | Entrada no campo de usuário e resposta da aplicação |
| [Tentativa de login FTP sem sucesso](images/captura%20que%20deu%20errado.png) | Resposta `530 Login incorrect` |

## Arquivos do projeto

| Arquivo ou pasta | Conteúdo |
|---|---|
| [documentacao/metodologia.md](documentacao/metodologia.md) | Etapas do trabalho e ferramentas usadas |
| [documentacao/setup-ambiente.md](documentacao/setup-ambiente.md) | Orientações para configurar o laboratório |
| [documentacao/tests.md](documentacao/tests.md) | Comandos, resultados e observações sobre as capturas |
| [documentacao/mitigacao.md](documentacao/mitigacao.md) | Medidas para reduzir o risco de tentativas de acesso |
| [reflexoes.md](reflexoes.md) | Aprendizados, dificuldades e pontos a revisar |
| `scripts/` | Scripts de apoio aos testes |
| `wordlists/` | Listas de usuários e senhas do laboratório |
| `images/` | Capturas de tela |
| `write_tests_md.py` e `write_tests_md2.py` | Scripts que gravam o texto de `tests.md` |

As listas disponíveis são `usuariom.txt`, `senham.txt`, `smb_users.txt`, `senhas_spray.txt` e `credentials.txt`, todas dentro de `wordlists/`. Nas capturas, algumas listas aparecem com outros nomes, como `users.txt` e `pass.txt`; essa diferença está indicada na documentação dos testes.

## Medidas de proteção

Os acessos encontrados no laboratório mostram o risco de manter credenciais previsíveis, como `msfadmin` / `msfadmin`. As medidas discutidas incluem usar senhas longas e exclusivas, limitar tentativas de login, adotar autenticação multifator quando disponível, restringir a exposição dos serviços e acompanhar os registros de autenticação. As recomendações e suas referências estão em [Medidas de proteção](documentacao/mitigacao.md).

## Como consultar o projeto

Para acompanhar o trabalho, comece pela metodologia e consulte os testes junto das imagens. Para montar outro laboratório, siga a configuração do ambiente e ajuste os comandos aos endereços e arquivos usados na sua instalação. Os scripts servem como apoio e ainda têm pontos de configuração e sintaxe descritos em [Reflexões](reflexoes.md).
