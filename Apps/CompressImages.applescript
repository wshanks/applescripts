(* Saved as an application, this script works as a droplet: you can drag and drop image files
onto its icon in order to compress them.
*)

on run
	set myFiles to choose file with prompt Â
		"Choose files to compress:" of type "public.image" with multiple selections allowed
	callCompressionScript(myFiles)
end run

on open myFiles
	callCompressionScript(myFiles)
end open

on callCompressionScript(myFiles)
	tell application "Finder" to get folder of (folder of (path to me)) as alias
	set parentDir to POSIX path of result
	set scriptdirectory to (parentDir & "Applescript/")
	
	set compressScript to load script (scriptdirectory & "CompressImages.scpt" as POSIX file)
	
	tell compressScript
		ProcessFiles(myFiles)
	end tell
end callCompressionScript