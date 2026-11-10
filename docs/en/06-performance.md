# 6. Performance beyond debloating

## Measure before and after

```bash
./scripts/measure.sh        # CPU and RAM for ~30 s
./scripts/diagnose.sh       # includes the processes using the most CPU
```

Always measure in the same state (for example, 10 minutes after power-on, no music). In the real case, the biggest lesson was: **if you don't measure before, you can't prove the gain afterwards.**

## 1. The launcher is often the culprit

In the real case, the third-party launcher (CarWebGuru) used **~92% of a core all the time**, more than everything else combined. It kept GPS in high-power mode, a music service and a notification listener running.

Test: temporarily switch to the stock launcher and measure.

```bash
# list available launchers
adb shell cmd package query-activities --brief -a android.intent.action.MAIN -c android.intent.category.HOME
# set the home screen (example with the stock launcher)
adb shell cmd package set-home-activity com.android.launcher/com.android.launcher2.Launcher
adb shell input keyevent KEYCODE_HOME
```

If the stock launcher is too ugly, [EV Home](https://github.com/prximenes/ev-home-launcher) was made for exactly this: it sits at ~0% CPU when idle and uses ~12–25 MB of memory.

### Apps that come back by themselves

Even off screen, the system may restart an app if it has an active **notification listener**:

```bash
adb shell settings get secure enabled_notification_listeners
adb shell cmd notification disallow_listener package/component.Of.Listener
```

## 2. Animations at 0.5×

Makes the head unit feel snappier when opening and switching apps:

```bash
adb shell settings put global window_animation_scale 0.5
adb shell settings put global transition_animation_scale 0.5
adb shell settings put global animator_duration_scale 0.5
# undo: settings delete global <name>
```

## 3. Block the Play Store in the background

Keeps the store working when you open it, but stops it from doing work on its own:

```bash
adb shell cmd appops set com.android.vending RUN_IN_BACKGROUND ignore
# undo: ... RUN_IN_BACKGROUND allow
```

## 4. Before installing apps: check the GPU

Many cheap head units have old GPUs. The AC8227L has a **Mali-450, OpenGL ES 2.0 only**:

```bash
adb shell dumpsys SurfaceFlinger | grep GLES
```

Modern map apps that **require OpenGL ES 3** crash on launch on these GPUs. In the real case, Organic Maps closed with `OpenGL ES3 is not supported`, and OsmAnd froze too. HERE WeGo didn't work either (its engine requires ES3). MapFactor Navigator, which renders on the CPU at below-Full-HD resolutions, opened without freezing.

In general, on these head units, **navigating on your phone via Android Auto/CarPlay** beats any map app installed on the head unit itself.

## 5. What not to do

- **Limit background processes** in Developer options: it tends to break Bluetooth, the radio and mirroring.
- **Change the CPU governor** or other kernel options: on most head units it's already set to `performance`, and changing it requires root.
- **Flash custom ROMs** without knowing how to recover the unit: there's a real risk of bricking it.

Next: [7. Troubleshooting](07-troubleshooting.md)
