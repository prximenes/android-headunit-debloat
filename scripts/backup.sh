#!/usr/bin/env bash
# Salva lista de pacotes e propriedades da central em backups/<data>/. Só leitura no aparelho.
source "$(dirname "$0")/common.sh"
require_device

OUT="$BACKUP_DIR/$(stamp)"
mkdir -p "$OUT"

ash getprop > "$OUT/getprop.txt"
ash pm list packages -f -u > "$OUT/pacotes_todos.txt"
ash pm list packages -s > "$OUT/pacotes_sistema.txt"
ash pm list packages -3 > "$OUT/pacotes_terceiros.txt"
ash pm list packages -d > "$OUT/pacotes_desativados.txt"
ash cmd package resolve-activity --brief -a android.intent.action.MAIN -c android.intent.category.HOME > "$OUT/launcher.txt"
ash settings get secure enabled_notification_listeners > "$OUT/notification_listeners.txt"

echo "Backup salvo em: $OUT"
wc -l "$OUT"/pacotes_*.txt
echo
echo "Atenção: getprop.txt contém o número de série do aparelho. Não publique."
