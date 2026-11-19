# Configuração do ambiente

O laboratório usa Kali Linux, Metasploitable 2 e DVWA. As máquinas virtuais devem ficar na mesma rede host-only do VirtualBox para permitir a comunicação entre elas durante os testes.

## Arquivos e máquinas virtuais

- [Kali Linux](https://www.kali.org/get-kali/): sistema usado para executar as ferramentas.
- [Metasploitable 2](https://sourceforge.net/projects/metasploitable/): máquina vulnerável fornecida como uma VM compactada. Depois de extrair o arquivo, use o disco virtual fornecido para configurar a máquina no VirtualBox. A [documentação da Rapid7](https://docs.rapid7.com/metasploit/metasploitable-2/) descreve esse ambiente.

Como referência para a configuração, as anotações do projeto indicam 2 GB de RAM, 2 vCPUs e 20 GB de disco para o Kali; para o Metasploitable 2, 1 GB de RAM e 1 vCPU, com o disco da própria VM. Esses recursos podem ser ajustados conforme o computador disponível.

## Rede e endereços

No VirtualBox, selecione um adaptador host-only para cada VM e confira se ambas usam a mesma rede. A rede prevista na documentação é `192.168.56.0/24`.

As capturas registram os seguintes endereços:

| Serviço | Endereço mostrado |
|---|---|
| FTP e SMB | `192.168.56.101` |
| DVWA no navegador | `127.0.0.1` |

O endereço `127.0.0.1` aponta para a própria máquina em que o navegador está aberto. Ao acessar o DVWA de outra máquina, use o IP do computador que hospeda a aplicação.

Antes de repetir os comandos, confira os endereços atribuídos às VMs. Os scripts contêm valores de referência que precisam ser ajustados ao ambiente atual.

## DVWA

Há duas opções descritas no projeto: usar o DVWA disponível no Metasploitable 2 ou instalá-lo com o XAMPP.

Na primeira opção, acesse `/dvwa` no servidor web da VM. Na segunda, inicie o servidor web e o banco de dados do XAMPP, coloque os arquivos do DVWA no diretório web e siga a configuração da [documentação oficial](https://github.com/digininja/DVWA).

Para o exercício, entre no DVWA com a conta de laboratório e selecione **Low** em **DVWA Security**. Nos comandos que usam uma sessão autenticada, confira o cookie atual antes de executar o teste.

O DVWA deve permanecer restrito ao laboratório. Alterar o nível para **High** não torna a aplicação adequada para exposição à internet; seus próprios autores recomendam mantê-la fora de servidores públicos.
