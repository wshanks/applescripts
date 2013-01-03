tell application "Finder" to get folder of (folder of (path to me)) as alias
set parentDir to POSIX path of result
set scriptdirectory to (parentDir & "AppleScript/")

run script (scriptdirectory & "SmartIpodSync.scpt" as POSIX file)
run script (scriptdirectory & "EjectDisks.scpt" as POSIX file)
run script (scriptdirectory & "VPNDisconnect.scpt" as POSIX file)