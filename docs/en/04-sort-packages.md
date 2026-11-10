# 4. Sorting packages

The goal is to split packages into three groups: **remove**, **decide** and **never touch**.

## How to investigate a package

```bash
adb shell pm list packages -3                    # installed later (third-party)
adb shell dumpsys package com.example | grep -E "versionName|codePath|firstInstallTime|installerPackageName"
```

- `codePath=/system/...` or `/vendor/...` → came from the factory.
- `codePath=/data/app/...` → installed later (by you, the seller or a previous owner).
- `installerPackageName=com.android.vending` → came from the Play Store.
- A `firstInstallTime` very different from the others → may be something installed without your knowledge.

Which app is the home screen (never remove it without switching first):

```bash
adb shell cmd package resolve-activity --brief -a android.intent.action.MAIN -c android.intent.category.HOME
```

## 🟢 Usually safe to remove

| Type | Examples |
|---|---|
| Factory tests and demos | `*.autotest`, `com.example.*` |
| Debug loggers | `com.mediatek.mtklogger`, `com.mediatek.mtklogger.proxy` |
| Google apps nobody uses in a car | Assistant, Feedback, Partner Setup, Backup Transport, Config Updater |
| Phone apps that make no sense in a car | Exchange, sound recorder, HTML viewer, browser bookmarks |
| Factory reminders and utilities | `com.bumblebee.remindeasy`, calculator |

## 🟡 Decide case by case

- **OTA update checker** (`*.otacheck`): if removed, the head unit stops receiving manufacturer updates.
- **Gallery**: only if you never open photos on the head unit.
- **Third-party apps** (Spotify, Waze, browsers): they're yours, your call.
- **Heavy third-party launchers** (e.g. CarWebGuru): see [6. Performance](06-performance.md).

## 🔴 Never remove (AC8227L / XY Auto head units)

| Function | Typical packages |
|---|---|
| Reverse camera and video inputs | `com.autochips.android.backcar` |
| Car Bluetooth | `com.autochips.bluetooth`, `com.android.bluetooth` |
| CAN bus and car controls | `com.xygala.*`, `com.pve.apsbridge`, `com.pve.appsetting` |
| Audio chip and equalizer | `com.xy.tda7729` |
| Manufacturer settings | `com.xyauto.Settings` |
| Stock radio, music and video | `com.acloud.stub.*` |
| Mirroring (Android Auto/CarPlay) and activation | `com.zjinnova.zlink`, `com.xy.zlinkactivationcode`, `com.kyhero.car.myhost*` |
| Dash cam | `com.williexing.*` |
| Video lock while driving | `com.xy.brakecheck` |
| GPS, keyboard and system | `com.mediatek.ygps`, `com.android.systemui`, `com.android.settings`, `com.android.phone`, the `providers` |
| Stock launcher | `com.android.launcher` (even if you use another one, keep it as a fallback) |

On **other platforms**, look for the equivalents: anything with the manufacturer's name (`fyt`, `syu`, `microntek`, `hct`, `ts10`), "can", "canbus", "mcu", "radio", "backcar", "avin", "bt".

> When in doubt, **don't remove it**. A small idle package weighs nothing. What weighs is the few that keep running (see [6. Performance](06-performance.md)).

Next: [5. Removing and undoing](05-remove-and-undo.md)
