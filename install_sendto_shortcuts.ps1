Get-ChildItem include | foreach { 
	$name = '_' + $_.BaseName
	$fullname = $_.FullName
	$directory = $pwd.Path
	$targetPath = '%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe'
	$arguments = '-NoLogo -NoProfile -ExecutionPolicy Bypass -File "' + $fullname + '"'
	$newLinkPath = $env:APPDATA + "\Microsoft\Windows\SendTo\" + $name + ".lnk"
	
	$Shell = New-Object -ComObject WScript.Shell
	$ShortCut = $Shell.CreateShortcut($newLinkPath)
	$ShortCut.TargetPath=$targetPath
	$ShortCut.Arguments=$arguments
	$ShortCut.WorkingDirectory = $directory;
	$ShortCut.WindowStyle = 1;
	# $ShortCut.Hotkey = "CTRL+SHIFT+F";
	$ShortCut.IconLocation = "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe";
	$ShortCut.Description = "sendto shortcut for powershell script";
	$ShortCut.Save()
}