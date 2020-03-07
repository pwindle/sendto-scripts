$count = 0
$percent = 0

$height = Read-Host -Prompt 'Give the new height (leave blank to not resize)'
if ($height -eq "") { $height = "-1" }
$resizeString = "-1:" + $height

foreach ($arg in $args) {
	$name = $arg.split(".")[0]
	$newname = $name + ".ogv"
	Write-Progress -Activity "Converting to webm" -Status "$percent_formatted% Complete:" -PercentComplete $percent;
	ffmpeg -i $arg -c:v libtheora -qscale:v 7 -vf scale=$resizeString -c:a libvorbis -qscale:a 5 -auto-alt-ref 0 $newname
	$count++
	$percent = $count / $args.count * 100
	$percent_formatted = "{0:n1}" -f $percent
}