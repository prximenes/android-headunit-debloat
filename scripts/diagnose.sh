#!/usr/bin/env bash
# Mostra informações da central e quem está gastando CPU. Só leitura.
source "$(dirname "$0")/common.sh"
require_device

prop() { ash getprop "$1"; }

echo "== Aparelho"
echo "Modelo:        $(prop ro.product.model)  (device: $(prop ro.product.device), marca: $(prop ro.product.brand))"
echo "Plataforma:    $(prop ro.board.platform)  |  ABI: $(prop ro.product.cpu.abilist)"
echo "Android:       $(prop ro.build.version.release)  (SDK $(prop ro.build.version.sdk) — o SDK é a versão real)"
echo "Build:         $(prop ro.build.display.id)  ($(prop ro.build.type))"
echo "GPU:           $(ash dumpsys SurfaceFlinger | grep -m1 'GLES:' | sed 's/^ *GLES: *//')"
echo "Tela:          $(ash wm size | sed 's/.*: //')  densidade $(ash wm density | sed 's/.*: //')"
echo

echo "== Memória"
ash cat /proc/meminfo | grep -E 'MemTotal|MemAvailable'
echo

echo "== Tela inicial atual"
ash cmd package resolve-activity --brief -a android.intent.action.MAIN -c android.intent.category.HOME | tail -1
echo

echo "== Leitores de notificação ativos (podem manter apps rodando)"
ash settings get secure enabled_notification_listeners
echo

echo "== Processos que mais gastam CPU (amostra de ~10 s)"
ash "top -n 2 -d 5 | grep -E '^ *[0-9]+ ' | sort -k9 -rn | head -12" | sed 's/\x1b\[[0-9;?]*[a-zA-Z]//g'
echo

echo "== Processos que mais usam RAM"
ash "ps -A -o RSS,NAME" | sort -rn | head -10
