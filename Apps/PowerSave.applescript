tell application "Finder" to get folder of (folder of (path to me)) as alias
set parentDir to POSIX path of result
set scriptdirectory to (parentDir & "AppleScript/")

set powerHungryApps to {"iTunes", "Thunderbird"}

run script (scriptdirectory & "PowerSave.scpt" as POSIX file) with parameters {powerHungryApps}