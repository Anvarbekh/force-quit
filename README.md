<img src="assets/icon-256.png" width="128" alt="Force Quit app icon: a yellow ring with an X on a dark rounded square">

# Force Quit

A tiny macOS app that opens the **Force Quit Applications** window. Use it
from any tool that can open an app, such as the Logi Options+ Actions Ring,
Stream Deck, Keyboard Maestro, or BetterTouchTool, where the ⌘⌥Esc shortcut
doesn't work.

## Why this exists

macOS only opens the Force Quit window when ⌘⌥Esc comes from a real keyboard.
When another app sends the same keys as a software keystroke, macOS ignores
them. As the Keyboard Maestro developer put it, simulating Command-Option-Escape
["will not trigger the Force Quit (it must happen at some lower level)"](https://forum.keyboardmaestro.com/t/f19-programing/32880).

So a "Force Quit" button on a mouse ring, macro pad, or launcher does nothing.
This app gives those tools something they can open instead.

## How it works

The app clicks **Apple menu > Force Quit…** for you, through Finder's menu bar
and macOS System Events. This method works even when synthetic keystrokes are
ignored.

- **Works in any language.** It finds the menu item by its ⌥⌘Esc shortcut, not
  by its English name.
- **Never picks the wrong item.** The hidden Shift version of the menu item,
  **Force Quit Finder**, would quit Finder immediately. It uses a different
  shortcut (⇧⌥⌘Esc), so the app never selects it.
- **Has safe fallbacks.** If a permission is missing, the app opens the right
  **Privacy & Security** page. If Finder isn't responding, it opens Activity
  Monitor, where you can still force quit apps.
- **Stays out of the way.** It has no Dock icon and no window. It opens the
  Force Quit window and exits.

## Install

You can build the app yourself or download a release. Building it yourself is
recommended, because macOS doesn't block apps you build on your own Mac.

### Option 1: Build from source

You only need the tools that come with macOS. Xcode isn't required.

1. Open Terminal and run:

   ```bash
   git clone https://github.com/Anvarbekh/force-quit.git
   cd force-quit
   ./build.sh
   ```

2. Move `build/Force Quit.app` to your **Applications** folder.

### Option 2: Download a release

The release app isn't notarized by Apple, so macOS blocks it the first time.

1. Download `Force-Quit-1.0.0.zip` from
   [Releases](https://github.com/Anvarbekh/force-quit/releases) and unzip it.
2. Move **Force Quit** to your **Applications** folder and open it.
3. When macOS says it can't verify the app, open **System Settings >
   Privacy & Security**, scroll down, and click **Open Anyway**.

## First run

The app needs two permissions to click the menu for you. macOS asks for them
the first time you open the app.

1. Open **Force Quit** from your Applications folder.
2. When asked whether Force Quit can control **System Events**, click
   **Allow**.
3. In **System Settings > Privacy & Security > Accessibility**, turn on
   **Force Quit**. The app opens this page for you if the permission is
   missing.
4. Open **Force Quit** again. The Force Quit Applications window appears.

> **Note:** macOS ties these permissions to the exact copy of the app. If you
> rebuild or update it, remove **Force Quit** from the Accessibility list with
> the **–** button and turn it on again.

## Use it from your tools

Any tool that can open an app can use Force Quit. These are common examples:

| Tool | Action to use |
| --- | --- |
| Logi Options+ Actions Ring | **Start application** (open an app), then choose **Force Quit** |
| Stream Deck | **System > Open**, then choose **Force Quit.app** |
| Keyboard Maestro | **Open a File, Folder or Application** |
| BetterTouchTool | **Launch Application / Open File / Open URL** |
| Raycast, Alfred, or Spotlight | Search for **Force Quit** |
| Shortcuts | **Open App** |

## Troubleshooting

These are the most common problems and their fixes.

- **Nothing happens.** Check that **Force Quit** is turned on in
  **Privacy & Security > Accessibility** and is allowed to control **System
  Events** under **Privacy & Security > Automation**.
- **It stopped working after an update or rebuild.** Remove **Force Quit**
  from the Accessibility list and turn it on again.
- **Activity Monitor opened instead.** Finder wasn't responding, so the app
  used its fallback. Press ⌘⌥Esc on your keyboard, or force quit from Activity
  Monitor.

## Uninstall

To remove the app completely, follow these steps:

1. Delete **Force Quit** from your Applications folder.
2. In **System Settings > Privacy & Security**, remove **Force Quit** from
   **Accessibility** and **Automation**.

## Development

The project has three parts:

- `src/ForceQuit.applescript` is the app's code.
- `build.sh` compiles the app, adds the icon and settings, and signs it.
- `scripts/make-icon.swift` redraws the icon. Run
  `swift scripts/make-icon.swift icon-1024.png` and convert the result with
  `iconutil` if you change the design.

To build with your own bundle ID, run `BUNDLE_ID=com.example.forcequit ./build.sh`.

## Background

- [Keyboard Maestro forum: simulating ⌘⌥Esc doesn't open Force Quit](https://forum.keyboardmaestro.com/t/f19-programing/32880)
- [Stack Overflow: CGEvents can't trigger the Force Quit Applications window](https://stackoverflow.com/questions/40592488/how-to-invoke-force-quit-applications-on-a-mac)

## License

[MIT](LICENSE)
