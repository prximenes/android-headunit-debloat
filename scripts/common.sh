#!/usr/bin/env bash
# Funções compartilhadas pelos scripts. Não rode diretamente.

set -euo pipefail

# Pasta raiz do repositório (onde ficam backups/)
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_DIR="$REPO_DIR/backups"

# adb sem o \r que alguns aparelhos devolvem
ash() { adb shell "$@" | tr -d '\r'; }

require_device() {
  command -v adb >/dev/null || { echo "adb não encontrado. Veja docs/01-preparacao.md" >&2; exit 1; }
  local n
  n=$(adb devices | awk 'NR>1 && $2=="device"' | wc -l)
  if [ "$n" -eq 0 ]; then
    echo "Nenhum aparelho conectado (adb devices vazio). Veja docs/02-ativar-adb.md" >&2
    exit 1
  elif [ "$n" -gt 1 ]; then
    echo "Mais de um aparelho conectado. Defina ANDROID_SERIAL=<serial> antes de rodar." >&2
    exit 1
  fi
}

# Lê um arquivo de lista: ignora linhas vazias e comentários (#), aceita "pacote  # comentário"
read_list() {
  sed -e 's/#.*//' -e 's/[[:space:]]//g' "$1" | grep -v '^$' || true
}

stamp() { date +%Y-%m-%d_%H%M; }
