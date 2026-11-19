# Metodologia

O desafio reuniu testes de autenticação em FTP, SMB e no formulário do DVWA. O trabalho foi feito em um laboratório com Kali Linux, Metasploitable 2 e DVWA, e os registros foram organizados junto dos comandos usados.

## Organização do trabalho

1. **Preparação do ambiente:** configurar as máquinas virtuais e a rede host-only no VirtualBox, mantendo os serviços vulneráveis no laboratório.
2. **Verificação de conectividade:** conferir o endereço da máquina de destino e testar a comunicação com `ping -c 3`. Nas capturas de FTP e SMB, o alvo aparece como `192.168.56.101`.
3. **Preparação dos testes:** selecionar o serviço, o módulo da ferramenta e as listas de usuários e senhas. A documentação também inclui comandos de enumeração com `enum4linux`.
4. **Tentativas de autenticação:** usar o Medusa nos testes de FTP e SMB e registrar as tentativas com Hydra e Medusa no formulário web. O material inclui ainda uma captura do exercício de SQL Injection no DVWA.
5. **Registro dos resultados:** reunir as saídas do terminal e as capturas, identificando os acessos confirmados e as tentativas que apresentaram erro.
6. **Medidas de proteção:** relacionar os problemas observados às recomendações de segurança apresentadas em [mitigacao.md](mitigacao.md).

## Ferramentas

| Ferramenta | Papel no projeto |
|---|---|
| Kali Linux | Sistema usado para os testes de segurança |
| Medusa | Tentativas de autenticação nos serviços |
| Hydra | Tentativas de autenticação no formulário web |
| enum4linux | Enumeração de informações SMB, descrita nas anotações |
| VirtualBox | Execução das máquinas virtuais |
| Metasploitable 2 | Máquina vulnerável usada no laboratório |
| DVWA | Aplicação com vulnerabilidades para estudo |
| smbclient | Cliente para consultar e testar serviços SMB |

Os comandos, as saídas e as observações de cada teste estão em [tests.md](tests.md). Os scripts servem como modelos para repetir o exercício: antes de usá-los, é preciso conferir os IPs, os caminhos das listas e os dados da sessão do DVWA.
