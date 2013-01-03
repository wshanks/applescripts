
on run {VPNname}
	tell application "System Events"
		tell current location of network preferences
			set VPNservice to service VPNname -- name of the VPN service
			
			if exists VPNservice then
				try
					connect VPNservice
				end try
				
				set connectionTimeOut to 15
				set endTime to (current date) + 15
				set isConnected to false
				repeat while ((current date) < endTime and not isConnected)
					set isConnected to connected of current configuration of VPNservice
					if not isConnected then
						delay 1
					end if
				end repeat
			end if
		end tell
	end tell
end run