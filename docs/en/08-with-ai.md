# 8. Doing it with AI

An AI agent with terminal access (Claude Code, Codex, Cursor, Aider and the like) can do almost everything in this guide for you: diagnose the head unit, sort the packages, run the scripts and measure the result. You remain responsible for **approving** what gets removed and **testing** the head unit between batches.

## Getting started

1. Do the [preparation](01-preparation.md) and [enable ADB](02-enable-adb.md). The physical part (cable, factory menu, accepting pop-ups) is yours.
2. Clone this repository and open the agent in its folder. The agent should read [AGENTS.md](../../AGENTS.md), which has the safety rules.
3. Use a request like this:

```text
I want to debloat my Android head unit following this repository.
Read AGENTS.md and the docs/ folder. It's connected over ADB.
1. Run the diagnosis and the backup, and measure current performance.
2. Sort the packages into: safe to remove, decide, and never touch, explaining each one.
3. Show me the first batch and wait for my approval before removing anything.
4. After each batch, wait for me to test the reverse camera, radio, Bluetooth, steering-wheel controls and Android Auto/CarPlay.
At the end, measure again and compare.
```

## What worked well in the real case

- Asking the agent to **show the list with the reason for each package** before removing.
- **Small batches**, with testing in between.
- Asking the agent to **find out what keeps running** (`top`, services, notification listeners). That, not the debloat itself, brought the biggest gain: the third-party launcher was eating a whole core.
- Asking it to **check the GPU before installing apps**. It would have avoided trying two incompatible map apps.

## Cautions

- The agent **can't see the head unit's screen** unless you allow it. It can read the screen structure with `uiautomator dump` (text only) or take a screenshot with `screencap`, but ask it to tell you first.
- If the agent suggests root, a custom ROM or changing other factory-menu options, **say no**. That's outside the scope of this guide and it's where the real risk lies.
- When the head unit disconnects, the fix is usually physical (USB mode or cable). The agent can't fix that on its own.
