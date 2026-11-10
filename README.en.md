# Debloating Android head units

[Português](README.md) · **English**

A hands-on guide to speeding up a "generic" Android car head unit (the Chinese units sold under many brands: Carloer, XY Auto, ALPS, Joying, Pumpkin and many others), **without root**, using just a laptop and a USB cable.

The guide comes from a real case: a **Carloer F9212B** head unit (**MediaTek/Autochips AC8227L** chip, 2 GB of RAM, Android 8.1 that reports itself as "10"). The result there was:

| | Before | After |
|---|---|---|
| CPU in use, head unit idle | ~44% | ~5–7% |
| Available RAM | ~720 MB | ~815 MB |
| Installed packages | 119 | 88 |

The commands work on practically any Android head unit. What changes from one unit to another is **how to enable ADB** and **which apps are essential**. This guide shows you how to find out both on yours.

> ⚠️ **Read before you start.** Everything here is reversible (nothing touches the system partition, and a factory reset brings everything back), but removing the wrong package can make the radio, reverse camera or steering-wheel controls disappear until you undo it. Follow the steps in order, back up first and remove in small batches. You are responsible for your device.

> The scripts print their messages in Brazilian Portuguese; the commands they run are explained in these docs.

## Who it's for

- **Doing it by hand:** follow the docs in order. Every command is explained.
- **Doing it with AI help** (Claude Code, Cursor, Codex, Aider or another agent with terminal access): read [docs/en/08-with-ai.md](docs/en/08-with-ai.md). The [AGENTS.md](AGENTS.md) file has the rules the agent must follow.

## Step by step

1. [Preparation: what to install on the laptop](docs/en/01-preparation.md)
2. [Enabling ADB on the head unit](docs/en/02-enable-adb.md), including the factory menu and "USB mode"
3. [Backup](docs/en/03-backup.md)
4. [Sorting packages: what to remove and what never to touch](docs/en/04-sort-packages.md)
5. [Removing in batches and undoing](docs/en/05-remove-and-undo.md)
6. [Performance beyond debloating](docs/en/06-performance.md): launcher, animations, background apps, GPU
7. [Troubleshooting](docs/en/07-troubleshooting.md)
8. [Doing it with AI](docs/en/08-with-ai.md)

## Scripts

In the [`scripts/`](scripts/) folder (bash; Linux and macOS, or Windows via WSL/Git Bash):

| Script | What it does |
|---|---|
| `diagnose.sh` | Shows model, chip, Android, GPU, RAM and the processes using the most CPU |
| `backup.sh` | Saves the package list and device info to a dated folder |
| `debloat.sh` | Removes the packages in a list file and generates a script to undo it |
| `restore.sh` | Reinstalls removed packages (from the rollback script or from a list) |
| `measure.sh` | Measures CPU and RAM for a few seconds, to compare before and after |

## Package lists

The [`lists/`](lists/) folder has annotated lists from the real case (AC8227L / XY Auto) and a list of **packages that must not be removed** on these units. Use them as a starting point, **never as the absolute truth**: check each package on your unit first.

Contributions with lists for other head units are welcome: see [lists/README.md](lists/README.md).

## Related project

- **EV Home**: a lightweight, electric-car-style launcher built for these head units after debloating: [prximenes/ev-home-launcher](https://github.com/prximenes/ev-home-launcher).

## License

[MIT](LICENSE).
