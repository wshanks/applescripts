-- Disconnect all VPN connections

on run
	tell application "System Events"
		tell current location of network preferences
			set VPNservices to the name of every service whose (kind is greater than 11 and kind is less than 16) and connected of current configuration is true
			repeat with VPNname in VPNservices
				set VPNservice to the service VPNname
				try
					disconnect VPNservice
				end try
			end repeat
		end tell
	end tell
	
	return 1
end run