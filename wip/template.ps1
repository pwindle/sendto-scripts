Write-Host "BEGINNING" -foreground "black" -background "red" -NoNewLine
Write-Host " " -NoNewLine
Write-Host $MyInvocation.MyCommand.Name -foreground "magenta" -background "black"
#$ElapsedTime = [System.Diagnostics.Stopwatch]::StartNew()
$script:starttime = get-date

$elapsedTime = $(get-date) - $script:StartTime
if ($elapsedTime.TotalSeconds -gt 60) {
	Write-Host ([math]::floor($elapsedTime.TotalSeconds/60)).ToString() -NoNewLine
	Write-Host "mins " -NoNewLine
	Write-Host ([math]::floor($elapsedTime.TotalSeconds%60)).ToString() -NoNewLine
	Write-Host "s"
}	#.ToString().PadRight(9,"0").PadLeft(10,"0") } 
else { $elapsedTime.TotalSeconds.ToString().PadRight(9,"0") + "s" | echo }
# echo $elapsedTime.TotalSeconds.ToString().PadRight(12,"0").PadLeft(12,"0")
# Write-Host ("{0:G8} seconds elapsed." -f $ElapsedTime.Elapsed.totalseconds) -background "white" -foreground "black"
Write-Host "COMPLETED" -foreground "black" -background "green" -NoNewLine
Write-Host " " -NoNewLine
Write-Host $MyInvocation.MyCommand.Name -foreground "magenta" -background "black" -NoNewLine
Write-Host "`a" -NoNewLine
$host.UI.RawUI.FlushInputBuffer()
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp")