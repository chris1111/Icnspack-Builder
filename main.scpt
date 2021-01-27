# Version "1.1" Icnspack-Builder Copyright (c) 2020,chris1111 All right reserved

use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions
--	Properties configuting the droplet shell
property appletDropImage : "IMGDocumentIcon"
property appletDropName : "Drop your Image files here"
property appletSearchName : "Find Image files"
property appletSearchImage : "IMGBadge"
global appletIsQuitting

--on appletFileIsAcceptable(theFile)
--	return true
--end appletFileIsAcceptable
on open dropped_files
	
	
	do shell script "afplay '/System/Library/Components/CoreAudio.component/Contents/SharedSupport/SystemSounds/System/payment_success.aif' &> /dev/null &"
	do shell script "rm -rf /tmp/Resource"
	do shell script "rm -rf /tmp/Icon"
	do shell script "rm -rf /tmp/Resource.zip"
	do shell script "mkdir -p  /Private/tmp/Resource"
	do shell script "mkdir -p  /Private/tmp/Icon"
	log "theFiles" & dropped_files
	
	set countFiles to count of dropped_files
	try
		set progress total steps to countFiles
		set progress completed steps to 0
		set progress description to "Processing images with Optimization! Wait…"
		delay 2
		display dialog "
Ready to proceed and create the themes.
An output ZIP file will be created (Resource.zip)" with icon note buttons {"Ready"} default button {"Ready"}
		{"Ready"}
		tell application "Icnspack-Builder"
			activate
		end tell
		
		set progress additional description to "Ready"
		set steps to 0
		repeat with aFile in dropped_files
			set steps to steps + 1
			set progress completed steps to steps
			set progress additional description to (name of (info for aFile)) & " (" & steps & "/" & countFiles & ")"
			delay 0.2 --1.0E-3
		end repeat
		
		display alert "Files Dropped!" message (countFiles as text) giving up after 1
		
		## Set use_terminal to true to run the script in a terminal
		set use_terminal to true
		## Set exit_terminal to true to leave the terminal session open after script runs
		set exit_terminal to true
		## Set log_file to a file path to have the output captured
		set file_list to ""
		set theFonts to dropped_files
		repeat with f in theFonts
			set fposix to the quoted form of the POSIX path of f
			do shell script "rsync " & fposix & " /tmp/Icon"
		end repeat
		set the_command to quoted form of POSIX path of (path to resource "icnspack-Build" in directory "Scripts")
		
		repeat with file_path in dropped_files
			set file_list to file_list & " " & quoted form of POSIX path of file_path
		end repeat
		set the_command to the_command & " " & file_list
		try
			if log_file is not missing value then
				set the_command to the_command & " | tee -a " & log_file
			end if
		end try
		try
			set use_terminal to false
		end try
		if not use_terminal then
			
			do shell script "afplay '/System/Library/Components/CoreAudio.component/Contents/SharedSupport/SystemSounds/System/Volume Unmount.aif' &> /dev/null &"
			do shell script the_command
			set progress additional description to "Build Done!"
			delay 1
			display alert "The images have been transformed into Icons" buttons "Done" default button "Done" giving up after 5
			set theAction to button returned of (display dialog "
Please select a destination to save the file Resource.zip

NOTE: If you have already a Resource.zip in this location, you must move it or rename to save another one otherwise it will be replaced." with icon note buttons {"Save"} default button {"Save"})
			{"Save"}
			if theAction = "Save" then
			end if
			
			tell application "Finder"
				set sourceFolder to (POSIX file "/Private/tmp/Resource.zip") as alias
				set DestFolder to choose folder with prompt "Choose destination Location" default location (path to desktop)
				duplicate sourceFolder to folder DestFolder with replacing
			end tell
			delay 0.5
			set myFile to "/Private/tmp/Resource.zip"
			try
				do shell script "rm -rf " & quoted form of myFile
			end try
		end if
	end try
	
end open
