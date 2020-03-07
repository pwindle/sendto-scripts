# settings taken from ffmpeg documentation: https://ffmpeg.org/ffmpeg-filters.html#toc-Examples-109
$count = 0
$percent = 0
foreach ($arg in $args) {
	$name = $arg.split(".")[0]
	$extension = $arg.split(".")[1]
	$newname = $name + "_stabilised." + $extension
	Write-Progress -Activity "Stabilising videos" -Status "$percent_formatted% Complete:" -PercentComplete $percent;
	ffmpeg -i $arg -vf vidstabdetect -f null -
	ffmpeg -i $arg -c:v libx264 -crf 22 -vf vidstabtransform,unsharp=5:5:0.8:3:3:0.4 -c:a aac $newname
	$count++
	$percent = $count / $args.count * 100
	$percent_formatted = "{0:n1}" -f $percent
	$host.UI.RawUI.WindowTitle = "$percent_formatted% complete"
}