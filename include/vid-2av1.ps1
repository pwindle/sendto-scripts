# the libaom encoder seems to be way too slow. no point. wait for a better encoder.
# rav1e is supposed to be faster but is still far too slow on my old work pc. another downside is only works with y4m files, even as an intermediary they are way too large. using it like this:
# rav1e test.y4m --output output.ivf 
# (updated 2019-08-30)


# Then use the following markup o fallback to mp4:
# <video>
#   <source src="path/to/video.webm" type="video/webm; codecs=vp9,vorbis">
#   <source src="path/to/video.mp4" type="video/mp4">
# </video>
$count = 0
$percent = 0
foreach ($arg in $args) {
	$name = $arg.split(".")[0]
	$newname = $name + ".av1.mp4"
	Write-Progress -Activity "Converting to webm" -Status "$percent_formatted% Complete:" -PercentComplete $percent;
	ffmpeg -i $arg -c:v libaom-av1 -crf 34 -b:v 0 -c:a libopus -strict experimental -auto-alt-ref 0 $newname
	$count++
	$percent = $count / $args.count * 100
	$percent_formatted = "{0:n1}" -f $percent
}