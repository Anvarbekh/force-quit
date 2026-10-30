#!/bin/bash
# Builds "build/Force Quit.app" and a zip for releases.
# Uses only tools that ship with macOS: osacompile, PlistBuddy, codesign, ditto.
set -euo pipefail
cd "$(dirname "$0")"

VERSION="1.0.0"
BUNDLE_ID="${BUNDLE_ID:-io.github.anvarbekh.forcequit}"
APP="build/Force Quit.app"
PLIST="$APP/Contents/Info.plist"

set_key() { # set_key <key> <type> <value>
	/usr/libexec/PlistBuddy -c "Set :$1 $3" "$PLIST" 2>/dev/null ||
		/usr/libexec/PlistBuddy -c "Add :$1 $2 $3" "$PLIST"
}

rm -rf build
mkdir -p build
osacompile -o "$APP" src/ForceQuit.applescript
cp assets/AppIcon.icns "$APP/Contents/Resources/applet.icns"

# osacompile adds usage strings for permissions this app never asks for.
for key in NSAppleMusicUsageDescription NSCalendarsUsageDescription NSCameraUsageDescription \
	NSContactsUsageDescription NSHomeKitUsageDescription NSMicrophoneUsageDescription \
	NSPhotoLibraryUsageDescription NSRemindersUsageDescription NSSiriUsageDescription \
	NSSystemAdministrationUsageDescription; do
	/usr/libexec/PlistBuddy -c "Delete :$key" "$PLIST" 2>/dev/null || true
done

set_key CFBundleIdentifier string "$BUNDLE_ID"
set_key CFBundleShortVersionString string "$VERSION"
set_key CFBundleVersion string "$VERSION"
set_key LSUIElement bool true
set_key NSAppleEventsUsageDescription string "Force Quit uses System Events to open the Force Quit Applications window."
set_key NSHumanReadableCopyright string "MIT License"

codesign --force --sign - "$APP"
codesign --verify --strict "$APP"
ditto -c -k --norsrc --noextattr --noacl --keepParent "$APP" "build/Force-Quit-$VERSION.zip"

echo "Built: $APP"
echo "Zip:   build/Force-Quit-$VERSION.zip"
