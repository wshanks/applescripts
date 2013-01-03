(* 
SMB_Connect prompts for a share login and then uses shareList and serverList to connect to
 that share at that server.  If the user entered share login is not in shareList, that 
 login is used with the first server in serverList.

shareList is a text list of names of SMB share logins.  
serverList is a list of servers corresponding to the list of shares in shareList.


*)

on run {shareList, serverList}
	tell application "Finder"
		set dialog_1 to display dialog Â
			"Username:" default answer ""
		set the sharedirectory to the text returned of dialog_1
		set shareIndex to my list_position(sharedirectory, shareList)
		if (shareIndex is not equal to 0) then
			set server to item shareIndex of serverList
		else
			set server to item 1 of serverList --Item 1 is the default server choice
		end if
		if not (exists disk sharedirectory) then
			set network_share to "smb://" & sharedirectory & "@" & server & "/" & sharedirectory
			try
				mount volume network_share
			end try
		end if
		
		if (exists disk sharedirectory) then
			open disk sharedirectory
		end if
	end tell
end run

on list_position(this_item, this_list)
	repeat with i from 1 to the count of this_list
		if item i of this_list is this_item then return i
	end repeat
	return 0
end list_position