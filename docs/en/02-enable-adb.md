# 2. Enabling ADB on the head unit

This is the part that varies most between head units. Try things in order.

## 2.1 Developer options and USB debugging

1. **Settings → About** → tap "Build number" **7 to 10 times**.
2. On some head units, you tap **"MCU version"** or "Kernel version" instead, and a password field appears.
3. Go back, open **Developer options** → turn on **USB debugging**.

## 2.2 ADB over Wi-Fi (only if the head unit offers it)

- **Genuine Android 11 or newer:** Developer options → **Wireless debugging** → "Pair with code". On the laptop:

  ```bash
  adb pair IP:PAIRING_PORT          # type the 6-digit code
  adb connect IP:MAIN_SCREEN_PORT
  ```

- **Android 10 or older:** the menu doesn't have this option. It only works after connecting once by cable (`adb tcpip 5555`).

> Many head units say "Android 10/11" but run Android 8.1 underneath. Check the real SDK with `adb shell getprop ro.build.version.sdk` (27 = Android 8.1). If "Wireless debugging" doesn't show up, that's your case.

Quick test that the head unit is on the network but ADB is off: `adb connect IP:5555` answers **"Connection refused"** (the port is closed).

## 2.3 By cable: "USB mode" (the trick)

On generic head units, the USB ports come in **host mode** (for flash drives and dash cams). In that mode the laptop **sees nothing**, even with USB debugging on.

1. Open the **factory settings** (see 2.4).
2. Look for **"USB mode"** (host / device). It may sit next to "usb port0/1 protocol" and "DVR enhancement".
3. Switch it to **device**, restart the head unit if asked, and **replug the cable**.
4. Try each of the head unit's USB ports. On some units only one becomes a device.

Diagnosis on the laptop (Linux):

```bash
lsusb                     # does the head unit show up? (e.g. "0e8d:201c MediaTek")
journalctl -k -n 20       # or: dmesg | tail  — shows USB connects and drops
adb devices               # should list the device as "device"
```

- If `lsusb` **shows nothing new**: it's a physical or USB mode problem (cable, port or host mode).
- If `lsusb` shows it but `adb devices` is empty or "unauthorized": accept the "Allow USB debugging" pop-up on the head unit's screen.
- On the first connection it's common for the head unit to appear for 3 seconds and drop. Replug the cable.

> **Important:** with USB in *device* mode, the **dash cam and flash drives stop working** on that port. Switch back to **host** when you're done.
>
> **After a restart**, the mode may silently go back to host, even if the menu still shows "device". Switch to host and back to device, then replug.

## 2.4 Factory menu

It's usually under **Settings → Factory settings**, protected by a password. The passwords most often mentioned for AC8227L / XY Auto units: **8888**, **1617**, **3711**. Other platforms use others (search for "*model* factory password").

⚠️ **In the factory menu, change only USB mode.** The other options control the CAN bus, camera, screen and audio. Write down the value of anything you change.

Next: [3. Backup](03-backup.md)
