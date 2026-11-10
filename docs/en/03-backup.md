# 3. Backup

Before removing anything, save the current state.

```bash
./scripts/backup.sh
```

The script creates `backups/YYYY-MM-DD_HHMM/` with:

| File | Contents |
|---|---|
| `getprop.txt` | All system properties (model, version, chip) |
| `pacotes_todos.txt` | All packages, with the APK path |
| `pacotes_sistema.txt` | System packages only |
| `pacotes_terceiros.txt` | Only those installed later (Play Store or APK) |
| `pacotes_desativados.txt` | Those already disabled |
| `launcher.txt` | Which app is the home screen today |

Without the scripts:

```bash
adb shell pm list packages -f > pacotes_todos.txt
adb shell pm list packages -3 > pacotes_terceiros.txt
adb shell getprop > getprop.txt
```

> 🔒 `getprop.txt` contains the device's **serial number**. Don't publish this file. The `backups/` folder is already in `.gitignore`.

## Apps you installed

`pm uninstall --user 0` on a **third-party** app (Play Store or APK) deletes the APK for good. If you want to be able to reinstall it without the store, copy the APK first:

```bash
adb shell pm path com.example.app          # shows /data/app/.../base.apk
adb pull /data/app/.../base.apk com.example.app.apk
```

**System** apps don't need this: the APK stays on the system partition and comes back with `install-existing`.

Next: [4. Sorting packages](04-sort-packages.md)
