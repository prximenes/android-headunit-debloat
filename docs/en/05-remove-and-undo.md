# 5. Removing in batches and undoing

## The command

```bash
adb shell pm uninstall -k --user 0 com.example.package
```

- Removes the app **only for user 0** (the head unit's only user).
- **System apps:** the APK stays on the system partition. Bring it back with:

  ```bash
  adb shell cmd package install-existing com.example.package
  ```

- **Third-party apps:** the APK is deleted. To bring it back, reinstall from the store or from the APK you saved in the [backup](03-backup.md).
- A **factory reset** restores all system apps.

## With the script

1. Create a list file (one package per line, `#` for comments). See [`lists/`](../../lists/).
2. Run:

   ```bash
   ./scripts/debloat.sh my-list.txt
   ```

   The script shows the packages, asks for confirmation, removes them one by one and writes `backups/rollback_<date>.sh` with the command to undo each successful removal.

3. To undo:

   ```bash
   ./scripts/restore.sh backups/rollback_<date>.sh
   ```

## In batches, testing in between

Remove 5 to 15 packages at a time. After each batch, test on the head unit:

- [ ] Reverse camera (shift into reverse)
- [ ] Radio
- [ ] Bluetooth: calls and music
- [ ] Steering-wheel controls
- [ ] Android Auto/CarPlay
- [ ] Restart the head unit and check it comes back normally

If something broke, undo the whole last batch, then put packages back one by one until you find the culprit.

## What to expect

The gain from debloating itself is **moderate**: idle apps cost almost nothing. The big gain comes from finding the few processes that **keep running all the time**. That's the next step.

Next: [6. Performance](06-performance.md)
