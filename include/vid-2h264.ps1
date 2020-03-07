# good old h264 for compatibility. https://trac.ffmpeg.org/wiki/Encode/H.264
# Use the following markup to fallback to mp4:
# <video>
#   <source src="path/to/video.webm" type="video/webm; codecs=vp9,vorbis">
#   <source src="path/to/video.mp4" type="video/mp4; codecs=avc1.4D401E,mp4a.40.2">
# </video>
$count = 0
$percent = 0

$height = Read-Host -Prompt 'Give the new height (leave blank to not resize)'
if ($height -eq "") { $height = "-1" }
$resizeString = "-1:" + $height

foreach ($arg in $args) {
	$name = $arg.split(".")[0]
	$newname = $name + ".h264.mp4"
	Write-Progress -Activity "Converting to mp4" -Status "$percent_formatted% Complete:" -PercentComplete $percent;
	ffmpeg -i  $arg -c:v libx264 -preset slow -crf 22 -vf scale=$resizeString -c:a aac -auto-alt-ref 0 $newname
	$count++
	$percent = $count / $args.count * 100
	$percent_formatted = "{0:n1}" -f $percent
}