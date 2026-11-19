# Testes realizados

Reuni aqui os comandos, os resultados e as capturas dos testes com FTP, SMB e o formulário do DVWA. Todos fazem parte do laboratório do desafio.

Nas capturas, os testes de FTP e SMB apontam para `192.168.56.101`, enquanto o DVWA está em `127.0.0.1`. Os comandos abaixo seguem os endereços dessas execuções. Ao repetir os testes, é preciso conferir quais IPs estão atribuídos às máquinas.

Os nomes `users.txt` e `pass.txt` aparecem nos comandos das capturas. No repositório, as listas estão organizadas na pasta `wordlists/`, com os nomes `usuariom.txt` e `senham.txt`. Para repetir os testes, é preciso conferir o caminho e o conteúdo das listas disponíveis.

## 1. Verificação de conectividade

O `ping` permite verificar se o endereço do laboratório responde antes dos testes. Para o alvo mostrado nas capturas, o comando seria:

```bash
ping -c 3 192.168.56.101
```

A opção `-c 3` limita a execução a três pacotes. Se os três retornarem, a saída informa três pacotes recebidos e nenhuma perda. Como não há uma captura dessa etapa, o comando fica aqui como referência, sem tempos de resposta atribuídos ao teste.

## 2. Força bruta em FTP

Usei o Medusa para testar as combinações das listas de usuários e senhas. Na captura, o comando aparece assim:

```bash
medusa -h 192.168.56.101 -U users.txt -P pass.txt -M ftp -t 6
```

| Parâmetro | Função no comando |
|---|---|
| `-h 192.168.56.101` | Define o endereço do alvo. |
| `-U users.txt` | Indica o arquivo com os usuários. |
| `-P pass.txt` | Indica o arquivo com as senhas. |
| `-M ftp` | Seleciona o módulo FTP. |
| `-t 6` | Define o número de logins testados em paralelo. |

O Medusa encontrou a combinação `msfadmin` / `msfadmin` e exibiu `ACCOUNT FOUND` com a indicação `[SUCCESS]`. As linhas `ACCOUNT CHECK` mostram as tentativas realizadas; a confirmação de uma credencial encontrada aparece na linha de sucesso.

Evidência: [execução do Medusa no FTP](../images/print%20do%20ftp%20medusa.png).

## 3. Confirmação do acesso por FTP

Depois do resultado do Medusa, fiz a conexão com o cliente FTP:

```bash
ftp 192.168.56.101
```

Ao entrar com o usuário `msfadmin`, o servidor respondeu `230 Login successful`. A tela também mostra o banner `220 (vsFTPd 2.3.4)`, a identificação do sistema remoto como UNIX e o prompt `ftp>` disponível. Isso confirma o login no serviço.

Também mantive a captura de uma tentativa que falhou. Nela, o servidor respondeu `530 Login incorrect` e o cliente exibiu `ftp: Login failed`. A imagem não permite identificar a senha digitada.

Evidências:

- [Login confirmado no FTP](../images/resultado%20ftp%20conectado.png).
- [Tentativa de login que falhou](../images/captura%20que%20deu%20errado.png).

## 4. Força bruta no formulário do DVWA

No teste web, usei o formulário **Brute Force** do DVWA. A captura mostra uma execução do Medusa e outra do Hydra, ambas direcionadas a `127.0.0.1`.

### Hydra

O comando abaixo reproduz a estrutura registrada na captura. O identificador da sessão foi substituído por `<ID_DA_SESSAO>`:

```bash
hydra -l admin -P pass.txt 127.0.0.1 http-get-form "/dvwa/vulnerabilities/brute/:username=^USER^&password=^PASS^&Login=Login:H=Cookie: PHPSESSID=<ID_DA_SESSAO>;security=low:F=Username and/or password incorrect."
```

O módulo `http-get-form` envia os parâmetros por GET. Nesse teste, o comando usa a mensagem `Username and/or password incorrect.` como indicação de falha na resposta do formulário.

Ao terminar, o Hydra informou `1 valid password found` e indicou o usuário `admin` com a senha `password`. Esse é o resultado exibido pela ferramenta na captura.

### Medusa

Na mesma imagem, o Medusa também apontou `admin` / `password`, mas exibiu o aviso `WARNING: Invalid method: form-data.`. Por isso, essa execução precisa ser revista antes de ser usada como confirmação de que o formulário foi configurado corretamente. O aviso é parte do resultado e foi mantido no registro.

Evidência: [execuções do Hydra e do Medusa no DVWA](../images/print%20brute%20force%20hydra%20e%20medusa.png).

## 5. Testes de autenticação no SMB

A documentação registra a enumeração com o `enum4linux` como parte da preparação:

```bash
enum4linux -a 192.168.56.101
```

O arquivo chamado `print smb do enu4linux.png`, porém, mostra a execução do Medusa, e não a saída do `enum4linux`. O comando visível nessa imagem é:

```bash
medusa -h 192.168.56.101 -U smb_users.txt -P senhas_spray.txt -M smbnt -t 2 -T 50
```

O Medusa encontrou `msfadmin` / `msfadmin` e exibiu `[SUCCESS (ADMIN$ - Access Allowed)]`.

Em seguida, o registro do `smbclient` mostra a consulta aos compartilhamentos com o usuário `msfadmin`:

```bash
smbclient -L \\192.168.56.101 -U msfadmin
```

A primeira tentativa listou os compartilhamentos `print$`, `tmp`, `opt`, `IPC$`, `ADMIN$` e `msfadmin`. Na mesma captura, uma segunda tentativa terminou com `NT_STATUS_LOGON_FAILURE`. Como a senha não aparece, não é possível atribuir essa falha a uma senha específica.

Evidências:

- [Resultado do Medusa no SMB](../images/print%20smb%20do%20enu4linux.png).
- [Listagem de compartilhamentos e tentativa que falhou](../images/resultado%20do%20smb%20.png).

## 6. Teste de entrada SQL no DVWA

Além das tentativas com listas de senhas, registrei uma entrada SQL no campo **Username** da página **Brute Force** do DVWA:

```text
admin' or '1'='1 --
```

A captura mostra essa entrada no formulário e uma mensagem de boas-vindas logo abaixo. Esse registro corresponde ao formulário de autenticação da página **Brute Force**. A senha digitada está oculta, e o endereço da página não aparece na imagem.

Evidência: [entrada SQL no formulário do DVWA](../images/print%20sql%20injection.png).

## Resultados registrados

| Teste | Alvo mostrado na captura | Resultado |
|---|---|---|
| FTP com Medusa | `192.168.56.101` | Encontrou `msfadmin` / `msfadmin`; o login foi confirmado no cliente FTP. |
| Formulário web com Hydra | `127.0.0.1` | Informou uma senha válida: `admin` / `password`. |
| Formulário web com Medusa | `127.0.0.1` | Indicou a mesma credencial, mas também apresentou um aviso de configuração. |
| SMB com Medusa | `192.168.56.101` | Encontrou `msfadmin` / `msfadmin` e indicou acesso ao compartilhamento `ADMIN$`. |
| Consulta com `smbclient` | `192.168.56.101` | Listou os compartilhamentos; uma segunda tentativa falhou. |
| Entrada SQL no DVWA | Endereço não visível nessa captura | O formulário exibiu uma mensagem de boas-vindas após a entrada mostrada. |

Os testes mostraram o uso de credenciais previsíveis no laboratório. As tentativas que falharam e o aviso do Medusa também ajudaram a perceber que é preciso conferir a saída completa e validar o acesso, em vez de considerar qualquer resposta da ferramenta como sucesso.
