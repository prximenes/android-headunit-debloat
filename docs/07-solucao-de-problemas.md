# 7. Solução de problemas

| Sintoma | Causa provável | O que fazer |
|---|---|---|
| `adb devices` vazio e `lsusb` sem nada novo | USB em modo host, cabo só de carga ou porta errada | Mude o USB mode para device ([passo 2](02-ativar-adb.md)), troque o cabo, teste as duas portas |
| Conectou e caiu depois de 3 segundos | Comum na primeira conexão | Reconecte o cabo |
| Parou de conectar depois de reiniciar a central | USB mode voltou para host | Troque para host e de volta para device, e reconecte |
| `unauthorized` | Falta aceitar a autorização | Aceite o pop-up na central e marque "Sempre permitir" |
| `adb connect IP:5555` → *Connection refused* | ADB por Wi-Fi desligado | Conecte por cabo primeiro |
| `pm revoke` não muda nada | Algumas ROMs ignoram em silêncio | Use `cmd appops set <pacote> <OP> ignore`, mas veja a próxima linha |
| Bloqueio por `appops` volta para "allow" sozinho | A ROM ou o próprio app reaplica | Não dá para forçar sem root; remova ou troque o app |
| Um app travou logo depois de instalar ou atualizar | No Android 8, o sistema às vezes abre o app no meio da instalação | Abra de novo |
| A tela "Escolher launcher" aparece | O launcher padrão travou ou foi atualizado | `cmd package set-home-activity <pacote>/<atividade>` |
| `uiautomator dump` faz o app de configurações do fabricante fechar | Bug na lista do fabricante (`PagedListView`) | Não use `uiautomator` nessas telas |
| `uiautomator dump` responde *could not get idle state* | Algum app redesenhando sem parar | Normal com música tocando em apps mal feitos; não é defeito da central |
| App de mapa fecha ao abrir | GPU sem OpenGL ES 3 | Veja a [seção de GPU](06-desempenho.md#4-antes-de-instalar-apps-veja-a-gpu) |
| A dash cam ou o pendrive pararam de funcionar | USB mode ficou em device | Volte para **host** |

## Desfazer tudo

1. `./scripts/restore.sh backups/rollback_*.sh` para cada lote.
2. Em último caso, **reset de fábrica** nas configurações da central. Isso restaura todos os apps de sistema, mas apaga os seus dados e apps instalados.
