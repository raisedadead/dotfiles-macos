-- Apple Script to quickly launch a QuickTime Player screen recording with a connected iPad
-- This can be used as a whiteboard when presenting 

on run
	try
		-- Launch if not running
		tell application "System Events"
			if not (exists process "QuickTime Player") then
				tell application "QuickTime Player" to activate
				delay 0.1
			end if
		end tell
		
		tell application "System Events"
			tell process "QuickTime Player"
				-- Create recording window
				click menu item "New Movie Recording" of menu "File" of menu bar item "File" of menu bar 1
				
				-- Quick window check
				repeat 3 times
					if exists (first window whose name contains "Recording") then
						exit repeat
					end if
					delay 0.1
				end repeat
				
				-- Get window and click camera
				click (first button of (first window whose name contains "Recording") whose description is "show capture device selection menu")
				delay 0.1
				
				-- Check for iPad
				set iPadFound to false
				set menuList to menu items of menu 1 of (first button of (first window whose name contains "Recording") whose description is "show capture device selection menu")
				
				repeat with menuItem in menuList
					if name of menuItem contains "iPad" then
						click menuItem
						set iPadFound to true
						exit repeat
					end if
				end repeat
				
				if not iPadFound then
					display dialog "No iPad detected. Please check your connection and try again." buttons {"OK"} default button "OK" with icon caution
				end if
			end tell
		end tell
		
	end try
end run
