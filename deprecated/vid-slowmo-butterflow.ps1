# just use ffmpeg slowmo it's as good or better than this anyway
# Requires butterflow.exe in path
# settings taken from butterflow documentation: https://github.com/dthpham/butterflow/blob/master/docs/Example-Usage.md
$spd = Read-Host -Prompt 'Give the new speed, e.g 0.5 for half speed (leave blank for half speed)'
$fps = Read-Host -Prompt 'Give the new frame rate, e.g 60 for 60 fps (leave blank for 60 fps)'
$scale = Read-Host -Prompt 'Give a scale, e.g. 0.5 for half the resolution (leave blank for no scale)'
if ( $spd -eq "" ) { $spd = "0.5" }
if ( $fps -eq "" ) { $fps = "60" }
if ( $scale -eq "" ) { $scale = "1" }

$count = 0
$percent = 0
foreach ($arg in $args) {
	$name = $arg.split(".")[0]
	$extension = $arg.split(".")[1]
	$newname = $name + "_butterflowed.mp4"
	Write-Progress -Activity "Butterflowing videos" -Status "$percent_formatted% Complete:" -PercentComplete $percent;
	butterflow -v -s full,spd=$spd -vs $scale -r $fps $arg -o $newname
	$count++
	$percent = $count / $args.count * 100
	$percent_formatted = "{0:n1}" -f $percent
	$host.UI.RawUI.WindowTitle = "$percent_formatted% complete"
}