tell application "Finder" to get folder of (folder of (path to me)) as alias
set parentDir to POSIX path of result
set scriptdirectory to (parentDir & "AppleScript/")

set wifiname to "wirelessnetworkname"
set VPNname to "VPN name"
set shareList to {"shareOnSDefaultServer", "shareOnServer2"}
set serverList to {"default.server.com", "server2.com"}

run script (scriptdirectory & "NetworkConnect.scpt" as POSIX file) with parameters {wifiname, VPNname, shareList, serverList}