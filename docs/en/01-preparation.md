# 1. Preparation

## On the laptop

All you need is **ADB** (Android Debug Bridge), Google's official tool for talking to Android devices.

**Linux (Debian/Ubuntu):**

```bash
sudo apt install adb
```

**macOS (Homebrew):**

```bash
brew install android-platform-tools
```

**Windows:** download the *SDK Platform-Tools* from the official Android site (developer.android.com/tools/releases/platform-tools), extract it and use the `adb.exe` inside the folder. To run this repository's scripts, use WSL or Git Bash.

Check:

```bash
adb version
```

### Optional: UAD-ng

[Universal Android Debloater Next Generation](https://github.com/Universal-Debloater-Alliance/universal-android-debloater-next-generation) is a graphical interface on top of ADB with a list of classified packages. It helps with phones, but covers little of the Chinese head units: most of their packages show up as "Unlisted". This guide does not depend on it.

## Take to the car

- **A USB data cable.** Many cables only charge. Test it with a phone first: if the laptop doesn't see the phone (`adb devices` or `lsusb`), the cable won't do.
- The cable type depends on the ports: usually USB-A (laptop) to USB-A or USB-C (head unit).
- A laptop with a charged battery. The process takes from 30 minutes to a few hours.

## On the head unit: write this down first

In **Settings → About** (or "System information"), note:

- Model and "device" (e.g. `8227L_demo`, `ums512_1h10`)
- Android and MCU versions
- Chip, if shown

This helps you find information specific to your model and pick the right package list.

Next: [2. Enabling ADB](02-enable-adb.md)
