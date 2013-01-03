tell application "Finder" to get folder of (folder of (path to me)) as alias
set parentDir to POSIX path of result
set scriptdirectory to (parentDir & "Bash/")

do shell script ("bash " & scriptdirectory & "ToggleHidden.sh")