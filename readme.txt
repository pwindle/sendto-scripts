sendto-scripts

A lot of simple scripts primarily made just for more convenient bulk selection and processing of images. It's much faster to select the target files then right-click > send-to than opening a command prompt and typing the needed line everytime.

REQUIREMENTS: 
Powershell
For converting images and videos: imagemagick, ffmpeg. 
Other: pdfsizeopt, Inkscape, Excel


INSTALLING:

Install the scripts by copying this folder to any location on your pc then running the shortcut link "install_sendto_shortcuts". 
The scripts will then be added to your Send To context menu accessed by right clicking a file in the file explorer. 

If for some reason that fails, type powershell into the address bar of the file explorer in the folder where the scripts are located, 
hit enter to open a powershell windows in the folder, then run the following and allow (press y then enter) for any prompts: 
Set-ExecutionPolicy RemoteSigned
.\install_sendto_shortcuts.ps1

USAGE

Select one or multiple files and process them with the scripts. The names should be descriptive enough or you will get a prompt for input.

MORE DETAILED USAGE INFO:

All of the scripts except the "overwrite-off" scripts (not included in installation) will overwrite the original file if the conversion 
is of the same file extension. The "overwrite-off" scripts ensure the original image is saved by appending a string to the converted files 
name. I choose not to include these scripts in installation as they duplicate functionality and add mental burden to choosing a script. 
For the same reason I exclude the "non-atomic" scripts which do bundled functionality of some of the other scripts. If you wish to ensure 
no original files are overwritten then you should back them up by copying them to a new folder, even if only temporarily, before running 
any scripts.


INFO ABOUT LINKS (OR HOW TO MANUALLY ADD LINKS):

All of the generic scripts which are installed with "install_sendto_shortcuts" are added to the "Send To" context menu as links/shortcuts. 
You can also install them manually like so:

Run from a shortcut with Target:
powershell.exe -ExecutionPolicy Bypass -File "path\to\your\script.ps1"

"-File" is necessary for passing arguments quoted. If omitted this fails with filenames that have spaces. (Parameters/Arguments are 
usually passed to the script space delimited, that is, with spaces between each of them)

"-ExecutionPolicy Bypass" is for portability. Run on any system and the executionpolicy shouldn't need to be changed.

