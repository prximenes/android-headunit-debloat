#!/usr/bin/env bash
# Mede CPU total e RAM disponível por ~30 s. Use antes e depois de cada mudança, no mesmo estado.
# Uso: ./scripts/measure.sh [rótulo]   → também anexa o resultado em backups/medicoes.txt
source "$(dirname "$0")/common.sh"
require_device

LABEL="${1:-sem rótulo}"
CPU=$(ash "top -n 4 -d 8 | grep -E '%cpu'" | sed 's/\x1b\[[0-9;?]*[a-zA-Z]//g' | tail -3 \
  | awk '{for(i=1;i<=NF;i++) if($i ~ /idle/){gsub(/%idle/,"",$i); idle+=$i; n++}} END{if(n) printf "%.0f", 400-idle/n}')
CORES=$(ash "grep -c ^processor /proc/cpuinfo")
AVAIL=$(ash cat /proc/meminfo | awk '/MemAvailable/{printf "%d", $2/1024}')
UP=$(ash uptime | sed 's/.*up \([^,]*\),.*/\1/')

LINE="$(date '+%F %T') | $LABEL | CPU em uso: ${CPU}% de $((CORES * 100))% | RAM disponível: ${AVAIL} MB | ligada há: $UP"
echo "$LINE"
mkdir -p "$BACKUP_DIR"
echo "$LINE" >> "$BACKUP_DIR/medicoes.txt"
