-- Force Quit: opens the macOS "Force Quit Applications" window.
--
-- macOS ignores Cmd-Opt-Esc when another app sends it as a synthetic keystroke
-- (Logi Options+ Actions Ring, Stream Deck, Keyboard Maestro, and others). This app
-- clicks Apple menu > Force Quit... instead, through Finder's menu bar.
-- https://github.com/Anvarbekh/force-quit

on run
	try
		set targetItem to my forceQuitMenuItem()
		tell application "System Events" to click targetItem
	on error errMsg number errNum
		if errNum is -1743 then
			-- Not allowed to control System Events (Automation permission).
			do shell script "open 'x-apple.systempreferences:com.apple.preference.security?Privacy_Automation'"
		else if errNum is -25211 or errMsg contains "assistive" then
			-- Not allowed to use Accessibility.
			do shell script "open 'x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility'"
		else
			-- Finder isn't responding, or the menu item wasn't found.
			tell application "Activity Monitor" to activate
		end if
	end try
end run

-- Finds "Force Quit..." in Finder's Apple menu.
-- 1. Exact English title (fast path).
-- 2. Any language: the item whose shortcut is Opt-Cmd-Esc (key code 53, modifiers 2).
--    The hidden Shift variant "Force Quit Finder" uses modifiers 3, so it never matches.
on forceQuitMenuItem()
	tell application "System Events"
		tell menu 1 of menu bar item 1 of menu bar 1 of process "Finder"
			set englishTitle to "Force Quit" & (character id 8230)
			if exists menu item englishTitle then return menu item englishTitle
			repeat with candidate in menu items
				try
					if (value of attribute "AXMenuItemCmdVirtualKey" of candidate) is 53 and ¬
						(value of attribute "AXMenuItemCmdModifiers" of candidate) is 2 then
						return contents of candidate
					end if
				end try
			end repeat
		end tell
	end tell
	error "Force Quit menu item not found." number -1728
end forceQuitMenuItem
