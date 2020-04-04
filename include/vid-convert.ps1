$filetype = Read-Host "Enter the desired output codec. Valid options:

h264
h265
vp8
vp9
ogv
av1

"

$height = Read-Host -Prompt 'Give the new height (leave blank to not resize)'
if ($height -eq "") { $height = "-1" }

$resizeString = "-1:" + $height
$ext = "mp4"

# Set command string
switch ($filetype)
{
	"h264" { $command = "-c:v libx264 -preset slow -crf 22 -vf scale=$resizeString -c:a aac -auto-alt-ref 0"; break }
	"h265" { $command = "-c:v libx265 -preset slow -crf 22 -vf scale=$resizeString -c:a aac -auto-alt-ref 0"; break }
	"vp8"  { $ext = "webm"; $command = "-c:v libvpx     -crf 30 -b:v 0 -vf scale=$resizeString -c:a libopus -deadline good -auto-alt-ref 0"; break }
	"vp9"  { $ext = "webm"; $command = "-c:v libvpx-vp9 -crf 30 -b:v 0 -vf scale=$resizeString -c:a libopus -deadline good -auto-alt-ref 0"; break }
	"ogv"  { $ext = "ogv"; $command = "-c:v libtheora -qscale:v 7 -vf scale=$resizeString -c:a libvorbis -qscale:a 5 -auto-alt-ref 0"; break }
	"av1"  { $command = "-c:v libaom-av1 -crf 34 -b:v 0 -vf scale=$resizeString -c:a libopus -strict experimental -auto-alt-ref 0"; break }
}

$count = 0
$percent = 0
foreach ($arg in $args) {
	$name = $arg.Substring(0, $arg.LastIndexOf('.'))
	$newname = $name + ".$filetype.$ext"
	Write-Progress -Activity "Converting to $filetype" -Status "$percent_formatted% Complete:" -PercentComplete $percent;
	Invoke-Expression "ffmpeg -i '$arg' $command '$newname'"
	$count++
	$percent = $count / $args.count * 100
	$percent_formatted = "{0:n1}" -f $percent
}

# NOTES:
	# the libaom encoder seems to be way too slow. no point. wait for a better encoder.
	# rav1e is supposed to be faster but is still far too slow on my old work pc. another downside is only works with y4m files, even as an intermediary they are way too large. using it like this:
	# rav1e test.y4m --output output.ivf 
	# (updated 2019-08-30)
	
	
	# Use the following markup To fallback to mp4:
	# <video>
	#   <source src="path/to/video.webm" type="video/webm; codecs=vp9,vorbis">
	#   <source src="path/to/video.mp4" type="video/mp4">
	# </video>