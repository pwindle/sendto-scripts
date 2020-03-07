# using settings from ffmpeg VP9 documentation: https://trac.ffmpeg.org/wiki/Encode/VP9#constantq
$count = 0
$percent = 0

$height = Read-Host -Prompt 'Give the new height (leave blank to not resize)'
if ($height -eq "") { $height = "-1" }
$resizeString = "-1:" + $height

foreach ($arg in $args) {
	$name = $arg.split(".")[0]
	$newname = $name + ".vp9.webm"
	Write-Progress -Activity "Converting to webm" -Status "$percent_formatted% Complete:" -PercentComplete $percent;
	ffmpeg -i  $arg -c:v libvpx-vp9 -crf 30 -b:v 0 -vf scale=$resizeString -c:a libopus -deadline good $newname
	$count++
	$percent = $count / $args.count * 100
	$percent_formatted = "{0:n1}" -f $percent
}