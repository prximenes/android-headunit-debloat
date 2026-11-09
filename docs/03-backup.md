# 3. Backup

Antes de remover qualquer coisa, salve o estado atual.

```bash
./scripts/backup.sh
```

O script cria `backups/AAAA-MM-DD_HHMM/` com:

| Arquivo | Conteúdo |
|---|---|
| `getprop.txt` | Todas as propriedades do sistema (modelo, versão, chip) |
| `pacotes_todos.txt` | Todos os pacotes, com o caminho do APK |
| `pacotes_sistema.txt` | Só os de sistema |
| `pacotes_terceiros.txt` | Só os instalados depois (Play Store ou APK) |
| `pacotes_desativados.txt` | Os já desativados |
| `launcher.txt` | Qual app é a tela inicial hoje |

Sem os scripts:

```bash
adb shell pm list packages -f > pacotes_todos.txt
adb shell pm list packages -3 > pacotes_terceiros.txt
adb shell getprop > getprop.txt
```

> 🔒 O `getprop.txt` contém o **número de série** do aparelho. Não publique esse arquivo. A pasta `backups/` já está no `.gitignore`.

## Apps instalados por você

`pm uninstall --user 0` em app de **terceiros** (Play Store ou APK) apaga o APK de vez. Se quiser poder reinstalar sem a loja, copie o APK antes:

```bash
adb shell pm path com.exemplo.app          # mostra /data/app/.../base.apk
adb pull /data/app/.../base.apk com.exemplo.app.apk
```

Apps de **sistema** não precisam disso: o APK continua na partição do sistema e volta com `install-existing`.

Próximo: [4. Classificar os pacotes](04-classificar-pacotes.md)
