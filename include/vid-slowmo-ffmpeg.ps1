# settings taken from ffmpeg documentation: https://ffmpeg.org/ffmpeg-filters.html#toc-Examples-109
$spd = Read-Host -Prompt 'Give the new speed, e.g 0.5 for half speed (leave blank for half speed)'
$fps = Read-Host -Prompt 'Give the new frame rate, e.g 60 for 60 fps (leave blank for 60 fps)'
$scale = Read-Host -Prompt 'Give a scale, e.g. 0.5 for half the resolution (leave blank for no scale)'
if ( $spd -eq "" ) { $spd = "2" } else { $spd = [string](1 / [double]$spd) }
if ( $fps -eq "" ) { $fps = "60" }
if ( $scale -eq "" ) { $scale = "1" }

$count = 0
$percent = 0
foreach ($arg in $args) {
	$name = $arg.split(".")[0]
	$extension = $arg.split(".")[1]
	$newname = $name + "_slowmo_ffmpeg.mp4"
	Write-Progress -Activity "Slowing and interpolating videos" -Status "$percent_formatted% Complete:" -PercentComplete $percent;
	$videoFilter = "setpts='" + $spd + "*PTS',minterpolate='mi_mode=mci:mc_mode=aobmc:vsbmc=1:fps=" + $fps + "',scale='iw*" + $scale + ":ih*" + $scale + "'"
	ffmpeg -i "$arg" -r $fps -vf $videoFilter "$newname"
	$count++
	$percent = $count / $args.count * 100
	$percent_formatted = "{0:n1}" -f $percent
	$host.UI.RawUI.WindowTitle = "$percent_formatted% complete"
}