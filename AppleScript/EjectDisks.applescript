-- This script should eject all ejectable disks except the optical drives

on run {noEjectList}
	tell application "Finder" to get folder of (folder of (path to me)) as alias
	set parentDir to POSIX path of result
	set scriptdirectory to (parentDir & "Bash/")
	
	set opticalDrives to (do shell script ("bash " & scriptdirectory & "opticalDisk.sh"))
	set oldDelims to AppleScript's text item delimiters
	set AppleScript's text item delimiters to return
	set opticalDriveList to every text item of opticalDrives
	set AppleScript's text item delimiters to oldDelims
	
	set noEjectList to noEjectList & opticalDriveList
	
	tell application "Finder"
		
		-- Add the startup disk to the list for good measure, though it should not
		-- be ejectable any way.
		copy name of startup disk to the end of noEjectList
		
		-- Loop through the list of ejectable disks and eject any that are not in the 
		-- noEjectList created above
		try
			set currentDisks to the name of every disk whose ejectable is true
		on error
			set currentDisks to {}
		end try
		repeat with diskName in currentDisks
			if (diskName is not in noEjectList) then
				try -- Don't give an error if a disk is busy
					eject diskName
				on error
					display dialog "Could not eject " & diskName & " with EjectDisks.scpt"
				end try
			end if
		end repeat
		
		try
			set currentDisks to the name of every disk whose local volume is false
		on error
			set currentDisks to {}
		end try
		
		repeat with diskName in currentDisks
			if (diskName is not in noEjectList) then
				try -- Don't give an error if a disk is busy
					eject diskName
				on error
					display dialog "Could not eject " & diskName & " with EjectDisks.scpt"
				end try
			end if
		end repeat
		
	end tell
end run