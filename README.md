Useful Applescripts
-------------------
This repository contains AppleScript files that I have found useful for various tasks, including syncing my iPod, connecting to VPN and SMB drives, ejecting removable drives before unplugging them, and compressing images, among others.

File formats
============
Files are stored in the repository as .applescript text files.  The files in `AppleScript` should be saved as script files (.scpt from the AppleScript Editor) and the files in `Apps` should be saved as applications (.app from the AppleScript Editor).  (There might be other ways to get everything to work together, but that is how I test things, so I can say what else will work for sure).

Calling the scripts
===================
The way I like to set up most of my AppleScripts is to write one script (.scpt) file that contains all of the script's logic and then create a second script that is saved as an application (.app) that calls the script and passes it any potential parameters.  To make the code for finding the .scpt files from the .app files easy, I save the .app files in one directory, the .scpt files in another directory named "AppleScript", and some .sh files in a third directory named "Bash" and store each of these three directories in the same parent directory.  Then the .scpt file can be found and called from .app file with code like

    tell application "Finder" to get folder of (folder of (path to me)) as alias
    set parentDir to POSIX path of result
    set scriptdirectory to (parentDir & "AppleScript/")
    run script (scriptdirectory & "scriptName.scpt" as POSIX file)

**More examples:**

* For an example of an application script running *AppleScripts* like this see `Apps/sleepPrep.applescript`.

* For an example of an application script running a *shell script* like this see `Apps/ToggleHidden.applescript`.

* For examples of applications running AppleScripts *with input arguments* see `Apps/NetworkConnect.applescript` and `PowerSave.applescript`.

* For an example of an application script that calls an AppleScript and functions as a *droplet* (you can drop other files onto its icon to have those files be the input to the called AppleScript) or as an application (it prompts to select the files to pass to the called AppleScript if you double-click on its icon), see `CompressImages.applescript`.

Enabling access for assistive devices
=====================================
Some of the scripts use the hack of clicking on UI elements with OS X's
accessibility functions (because there is no obvious way of scripting their
functionality directly).  Old versions of the scripts would check that the
accessibility functionality was enabled and help the user enable it if it was
not.  With Mavericks, this functionality must be turned on on a per-app basis.
When an app tries to use this functionality, if it does not have permission, OS
X prompts the user to enable the app if desired, so the scripts no longer
provide any prompting of their own.  They will fail on first run but should work
after they have been given permission to use the accessibility features.

