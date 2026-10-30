<img src="assets/icon-256.png" width="128" alt="Force Quit app icon: a yellow ring with an X on a dark rounded square">

# Force Quit

A tiny macOS app that opens the **Force Quit Applications** window. Use it
from tools that can open an app but can't trigger ⌘⌥Esc, such as the Logi
Options+ Actions Ring, Stream Deck, Keyboard Maestro, or BetterTouchTool.

macOS only opens the Force Quit window when ⌘⌥Esc comes from a real keyboard.
When another app sends the same keys, macOS
[ignores them](https://forum.keyboardmaestro.com/t/f19-programing/32880).
This app clicks **Apple menu > Force Quit…** for you instead.

- Works in any macOS language, because it finds the menu item by its ⌥⌘Esc
  shortcut.
- Never selects the hidden **Force Quit Finder** item, which quits Finder
  right away.
- Has no Dock icon or window. If a permission is missing, it opens the right
  settings page. If Finder isn't responding, it opens Activity Monitor.

## Install

Build it with the tools that come with macOS. You don't need Xcode.

```bash
git clone https://github.com/Anvarbekh/force-quit.git
cd force-quit && ./build.sh
```

Then move `build/Force Quit.app` to your **Applications** folder.

You can also download the zip from
[Releases](https://github.com/Anvarbekh/force-quit/releases). The app isn't
notarized, so the first time you open it, go to **System Settings > Privacy &
Security** and click **Open Anyway**.

## First run

Open **Force Quit** once and grant two permissions:

1. Click **Allow** when it asks to control **System Events**.
2. Turn on **Force Quit** in **System Settings > Privacy & Security >
   Accessibility**.

Then open it from any launcher, for example with **Start application** in the
Logi Options+ Actions Ring or **System > Open** on Stream Deck.

> **Note:** macOS ties these permissions to the exact copy of the app. If you
> rebuild or update it and nothing happens, remove **Force Quit** from the
> Accessibility list and turn it on again.

## License

[MIT](LICENSE). The code is in `src/ForceQuit.applescript`, `build.sh` builds
the app, and `scripts/make-icon.swift` draws the icon.
