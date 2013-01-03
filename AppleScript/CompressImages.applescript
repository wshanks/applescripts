on ProcessFiles(myFiles)
	set dialog1 to display dialog Â
		"Choose a compression rate between 1 and 100 (anything else to cancel):" default answer ""
	set myCompressionRate to the text returned of dialog1 as number
	if (myCompressionRate > 100) or (myCompressionRate < 1) then
		return
	end if
	
	set overwriteDialog to display dialog "Overwrite originals (if .jpg's)?" buttons {"Yes", "No"} default button 2
	set answer to button returned of overwriteDialog
	
	if answer is equal to "Yes" then
		set overwriteBool to true
	else
		set overwriteBool to false
	end if
	
	set oldDelimiter to AppleScript's text item delimiters
	repeat with myFile in myFiles
		set ItemInfo to the info for myFile
		if not folder of ItemInfo then
			ProcessSingleFile(myFile, myCompressionRate, overwriteBool)
		end if
	end repeat
	set AppleScript's text item delimiters to oldDelimiter
end ProcessFiles

on ProcessSingleFile(myFileAlias, myCompressionRate, overwriteBool)
	set myPosixFile to quoted form of POSIX path of myFileAlias
	
	set astid to AppleScript's text item delimiters
	set AppleScript's text item delimiters to "."
	set myRootPath to text 1 thru text item -2 of myPosixFile
	set AppleScript's text item delimiters to astid
	
	if overwriteBool then
		set myPosixNewItem to myRootPath & ".jpg'"
	else
		set myPosixNewItem to myRootPath & " -" & myCompressionRate & ".jpg'"
	end if
	
	set myShellString to ("sips -s format jpeg -s formatOptions " & myCompressionRate & " " & myPosixFile & " --out " & myPosixNewItem & " ; ")
	
	-- do it
	do shell script myShellString
	
end ProcessSingleFile