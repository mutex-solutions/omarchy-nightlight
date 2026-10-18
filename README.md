# Night light

Night light for Omarchy. A bar widget, or a section inside
[Deck](https://github.com/mutex-solutions/omarchy-deck).

## Standalone

```bash
omarchy plugin add https://github.com/mutex-solutions/omarchy-nightlight --enable
```

Click the moon: one switch, and the temperature currently in use.

## Inside Deck

```bash
omarchy plugin add https://github.com/mutex-solutions/omarchy-nightlight
```

```json
{ "id": "nightlight", "title": "Night light",
  "file": "/home/YOU/.config/omarchy/plugins/mutex-solutions.nightlight/deck/Section.qml",
  "page": "/home/YOU/.config/omarchy/plugins/mutex-solutions.nightlight/deck/Page.qml" }
```

`install-bundle.sh` in the Deck repo does this for every section at once.

## How it is built

| File | Role |
| --- | --- |
| `State.qml` | reads status and toggles through Omarchy's command |
| `deck/Section.qml` | the five members Deck reads |
| `deck/Page.qml` | the panel content |
| `Panel.qml` | the standalone bar widget and its popup |

Omarchy owns night light as a service plugin, and a third-party plugin is given
a scoped facade without service access. The supported interface is therefore the
command itself: `omarchy-toggle-nightlight --status` to read, no argument to
toggle. The state is re-read every ten seconds so the tile stays honest if the
toggle is flipped from the Omarchy menu.

## Requirements

Omarchy 4.x with `hyprsunset`.

## Licence

MIT. See [LICENSE](LICENSE).
