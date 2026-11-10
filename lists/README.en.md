# Package lists

[Português](README.md) · **English**

Format: **one package per line**. `#` starts a comment (the whole line or the end of a line).

```text
# comment
com.example.app          # what it is and why remove it
```

| File | Use |
|---|---|
| `ac8227l-xyauto-seguro.txt` | Low-risk batch tested on a Carloer F9212B (AC8227L, XY Auto, Android 8.1) |
| `ac8227l-xyauto-decidir.txt` | Packages that depend on how you use the unit (OTA, gallery, common third-party apps) |
| `ac8227l-xyauto-nunca-remover.txt` | Essential packages on these units. **Don't use it with `debloat.sh`**: it's a reference list |

The comments inside the lists are in Portuguese.

## How to use

```bash
cp lists/ac8227l-xyauto-seguro.txt my-list.txt
# edit it: delete what you want to keep
./scripts/debloat.sh my-list.txt
```

`debloat.sh` skips packages that aren't installed and refuses to remove the current home screen.

## Contributing your head unit

Open a pull request with a `lists/<chip>-<manufacturer>-<type>.txt` file containing, at the top:

- model, chip (`ro.board.platform`) and real Android version (`ro.build.version.sdk`)
- what was tested after removal (camera, radio, Bluetooth, steering wheel, mirroring)

**Don't include** serial numbers, a full `getprop.txt` or personal data.
