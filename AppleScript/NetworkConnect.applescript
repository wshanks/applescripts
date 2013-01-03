(*
This script checks the current wifi network connection and attempts to connect the VPN 
service VPNname if the wife network name is not wifiname.  Then it runs SMB_Connect with 
lists shareList and serverList.  

shareList is a text list of names of SMB share logins.  
serverList is a list of servers corresponding to the list of shares in shareList.  
SMB_Connect prompts for a share login and then uses shareList and serverList to connect 
to that share at that server.  If the user entered share login is not in shareList, that 
login is used with the first server in serverList.
*)

on run {wifiname, VPNname, shareList, serverList}
	tell application "Finder" to get folder of (folder of (path to me)) as alias
	set parentDir to POSIX path of result
	set scriptdirectory to (parentDir & "AppleScript/")
	
	set currentWifi to do shell script "networksetup -getairportnetwork en1 | awk '{print $4}'"
	
	if currentWifi is not wifiname then
		run script (scriptdirectory & "VPNConnect.scpt" as POSIX file) with parameters VPNname
	end if
	display dialog shareList
	display dialog serverList
	run script (scriptdirectory & "SMB_Connect.scpt" as POSIX file) with parameters {shareList, serverList}
end run

#######

# The following code can be used to correlate OSX usernames with default login names...
(*
set username to do shell script "whoami"
if username is "user1" then
	set username to "userlogin1"
end if
*)