tell application "Finder" to get folder of (folder of (path to me)) as alias
set parentDir to POSIX path of result
set scriptdirectory to (parentDir & "AppleScript/")

tell application "System Events" to set iTunesRunning to (name of processes) contains "iTunes"
if iTunesRunning then
	run script (scriptdirectory & "SmartIpodSync.scpt" as POSIX file)
end if


set protectedDisks to {""}
run script (scriptdirectory & "EjectDisks.scpt" as POSIX file) with parameters {protectedDisks}

run script (scriptdirectory & "VPNDisconnect.scpt" as POSIX file)
