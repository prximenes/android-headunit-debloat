#!/usr/bin/env bash
# Reinstala pacotes removidos com debloat.sh.
#
# Uso: ./scripts/restore.sh backups/rollback_XXXX.sh   (script gerado pelo debloat.sh)
#      ./scripts/restore.sh lista.txt                   (lista de pacotes)
#      ./scripts/restore.sh com.exemplo.pacote          (um pacote)
source "$(dirname "$0")/common.sh"

ARG="${1:-}"
[ -n "$ARG" ] || { echo "Uso: $0 <rollback.sh | lista.txt | pacote>" >&2; exit 1; }
require_device

if [ -f "$ARG" ]; then
  if grep -q 'install-existing' "$ARG"; then
    mapfile -t PKGS < <(grep -oE 'install-existing [^ ]+' "$ARG" | awk '{print $2}')
  else
    mapfile -t PKGS < <(read_list "$ARG")
  fi
else
  PKGS=("$ARG")
fi

for p in "${PKGS[@]}"; do
  r=$(ash cmd package install-existing "$p" 2>&1 || true)
  echo "$p -> $r"
done
echo
echo "Se algum app de terceiros não voltou, reinstale pela Play Store ou pelo APK salvo no backup."
