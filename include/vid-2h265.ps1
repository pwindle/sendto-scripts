# this is also slow. just use h264 (as of 2019)
# Then use the following markup to fallback to mp4:
# <video>
#   <source src="path/to/video.webm" type="video/webm; codecs=vp9,vorbis">
#   <source src="path/to/video.mp4" type="video/mp4">
# </video>
$count = 0
$percent = 0
foreach ($arg in $args) {
	$name = $arg.split(".")[0]
	$newname = $name + "h265.mp4"
	Write-Progress -Activity "Converting to webm" -Status "$percent_formatted% Complete:" -PercentComplete $percent;
	ffmpeg -i  $arg -c:v libx265 -preset slow -crf 22 -c:a aac -auto-alt-ref 0 $newname
	$count++
	$percent = $count / $args.count * 100
	$percent_formatted = "{0:n1}" -f $percent
}