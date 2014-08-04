-- This script turns off the "Live updating" property of each smart playlist
-- that is sync'ed to a currently connected iPod and that currently has "Live
-- updating" enabled.  Then it sync's all iPods and ejects them.  Finally, it 
-- turns "Live updating" back on for each playlist for which it turned it off.
-- A property (Access for assistive devices) in Universal Access must be enabled 
-- for the script to set the "Live updating" property of smart playlists.  The 
-- script walks the user through enabling this property if it is 
-- not set.

property livePlaylists : {}
property editable : true

-- Get list of connected iPods
set ipodList to {}
tell application "iTunes"
	-- Get list of connected iPods
	try -- Avoid error if there are no iPods connected
		set ipodList to (name of every source whose kind is iPod)
	end try
end tell
if (count of ipodList) is 0 then
	return 0 -- No iPods connected
end if

tell application "iTunes"
	--First delete played podcasts so they are not sync'ed below
	(* iTunes 11.2 re-downloads podcasts deleted in this way
	set podcastList to file tracks of user playlist "Podcasts"
	repeat with tempPodcast in podcastList
		if played count of tempPodcast > 0 then
			set fileLocation to location of tempPodcast
			tell application "Finder"
				delete file fileLocation
			end tell
			delete tempPodcast
		end if
	end repeat
	*)
	
	-- Loop through
	repeat with ipodName in ipodList
		set smartPlaylists to (name of user playlists in source ipodName whose smart is true and special kind is none)
		repeat with smartName in smartPlaylists
			reveal user playlist smartName
			activate
			tell application "System Events" to tell process "iTunes"
				tell menu item "Edit Smart Playlist" of menu 1 of menu bar item 3 of menu bar 1
					try
						if not enabled then
							set editable to false
							error 0
						end if
						click
					end try
				end tell
				tell window smartName
					if value of checkbox "Live updating" is 1 then
						click checkbox "Live updating"
					end if
					if smartName is not in livePlaylists then
						set end of livePlaylists to smartName
					end if
					click button "OK"
				end tell
			end tell
		end repeat
	end repeat
	
	repeat with ipodName in ipodList
		update ipodName
		tell me to waitForSync()
	end repeat
	
	repeat with ipodName in ipodList
		eject ipodName
	end repeat
	
	(* Reverse order because the last playlist dealt with will be left selected and usually the top playlist is the most prominent one *)
	set livePlaylists to reverse of livePlaylists
	set counter to 0
	repeat with smartName in livePlaylists
		--counter shouldn't be necessary but stops script from doing extra loops over list contents....
		set counter to (counter + 1)
		reveal user playlist smartName
		activate
		tell application "System Events" to tell process "iTunes"
			tell menu item "Edit Smart Playlist" of menu 1 of menu bar item 3 of menu bar 1
				try
					if not enabled then
						set editable to false
						error 0
					end if
					click
				end try
			end tell
			tell window smartName
				if value of checkbox "Live updating" is 0 then
					click checkbox "Live updating"
				end if
				click button "OK"
			end tell
		end tell
	end repeat
end tell

tell application "Finder"
	set visible of process "iTunes" to false
end tell

return counter


on waitForSync()
	tell application "System Events" to tell application process "iTunes"
		set theStatusText to ""
		repeat until theStatusText is "iPod sync is complete."
			--With iTunes 11, the sync is complete message is hidden in the status window
			--and has to be scrolled to.  Just loop through status window views here so that the script 
			--isn't dependent on the window's status.
			-- The try statement was added to avoid errors when there are 0 or 1 messages and 
			-- so no buttons to click.
			try
				click ((buttons of scroll area 1 of window "iTunes") whose description is "show next view")
			end try
			set theStatusText to value of static text 1 of scroll area 1 of window "iTunes"
			delay 1
		end repeat
	end tell
end waitForSync
