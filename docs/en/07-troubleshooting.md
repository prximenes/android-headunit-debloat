# 7. Troubleshooting

| Symptom | Likely cause | What to do |
|---|---|---|
| `adb devices` empty and `lsusb` shows nothing new | USB in host mode, charge-only cable or wrong port | Switch USB mode to device ([step 2](02-enable-adb.md)), change the cable, try both ports |
| It connected and dropped after 3 seconds | Common on the first connection | Replug the cable |
| Stopped connecting after restarting the head unit | USB mode went back to host | Switch to host and back to device, then replug |
| `unauthorized` | Authorization not accepted yet | Accept the pop-up on the head unit and tick "Always allow" |
| `adb connect IP:5555` → *Connection refused* | ADB over Wi-Fi is off | Connect by cable first |
| `pm revoke` changes nothing | Some ROMs silently ignore it | Use `cmd appops set <package> <OP> ignore`, but see the next row |
| An `appops` block goes back to "allow" by itself | The ROM or the app reapplies it | Can't be forced without root; remove or replace the app |
| An app crashed right after installing or updating | On Android 8, the system sometimes launches the app mid-install | Open it again |
| The "Choose launcher" screen appears | The default launcher crashed or was updated | `cmd package set-home-activity <package>/<activity>` |
| `uiautomator dump` makes the manufacturer's settings app close | Bug in the manufacturer's list (`PagedListView`) | Don't use `uiautomator` on those screens |
| `uiautomator dump` answers *could not get idle state* | Some app keeps redrawing | Normal with music playing in poorly written apps; not a head unit fault |
| A map app closes on launch | GPU without OpenGL ES 3 | See the [GPU section](06-performance.md#4-before-installing-apps-check-the-gpu) |
| The dash cam or flash drive stopped working | USB mode was left in device | Switch back to **host** |

## Undo everything

1. `./scripts/restore.sh backups/rollback_*.sh` for each batch.
2. As a last resort, a **factory reset** from the head unit's settings. It restores all system apps, but erases your data and installed apps.
