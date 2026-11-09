#!/usr/bin/env bash
# Remove (só para o usuário 0) os pacotes de uma lista e gera um script para desfazer.
#
# Uso: ./scripts/debloat.sh lista.txt [--yes]
#   lista.txt: um pacote por linha; '#' inicia comentário.
#   --yes: não pede confirmação (útil para agentes de IA DEPOIS de o usuário aprovar a lista).
source "$(dirname "$0")/common.sh"

LIST="${1:-}"
[ -n "$LIST" ] && [ -f "$LIST" ] || { echo "Uso: $0 lista.txt [--yes]" >&2; exit 1; }
require_device

mapfile -t PKGS < <(read_list "$LIST")
[ "${#PKGS[@]}" -gt 0 ] || { echo "A lista está vazia." >&2; exit 1; }

INSTALLED=$(ash pm list packages | sed 's/^package://')
HOME_PKG=$(ash cmd package resolve-activity --brief -a android.intent.action.MAIN -c android.intent.category.HOME | tail -1 | cut -d/ -f1)

echo "Pacotes na lista:"
TODO=()
for p in "${PKGS[@]}"; do
  if ! grep -qx "$p" <<<"$INSTALLED"; then
    echo "  -  $p  (não instalado, pulando)"
  elif [ "$p" = "$HOME_PKG" ]; then
    echo "  !! $p  é a TELA INICIAL atual — troque o launcher antes. Pulando."
  else
    echo "  x  $p"
    TODO+=("$p")
  fi
done
[ "${#TODO[@]}" -gt 0 ] || { echo "Nada a remover."; exit 0; }

if [ "${2:-}" != "--yes" ]; then
  read -r -p "Remover ${#TODO[@]} pacote(s)? [s/N] " ans
  [[ "$ans" =~ ^[sSyY]$ ]] || { echo "Cancelado."; exit 0; }
fi

mkdir -p "$BACKUP_DIR"
ROLLBACK="$BACKUP_DIR/rollback_$(stamp).sh"
{
  echo "#!/usr/bin/env bash"
  echo "# Desfaz as remoções de $(date). Apps de terceiros podem precisar ser reinstalados pela loja/APK."
} > "$ROLLBACK"
chmod +x "$ROLLBACK"

ok=0; fail=0
for p in "${TODO[@]}"; do
  r=$(ash pm uninstall -k --user 0 "$p" 2>&1 || true)
  if [ "$r" = "Success" ]; then
    echo "ok    $p"
    echo "adb shell cmd package install-existing $p" >> "$ROLLBACK"
    ok=$((ok + 1))
  else
    echo "falha $p  ($r)"
    fail=$((fail + 1))
  fi
done

echo
echo "Removidos: $ok  |  Falhas: $fail"
echo "Para desfazer: ./scripts/restore.sh $ROLLBACK"
echo "Agora teste: câmera de ré, rádio, Bluetooth, volante, Android Auto/CarPlay, reinício."
