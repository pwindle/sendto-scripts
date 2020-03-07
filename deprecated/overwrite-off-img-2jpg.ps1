# settings from comment thread on this stackoverflow answer: https://stackoverflow.com/a/7262050
# and as recommended by google for optimisation: https://developers.google.com/speed/docs/insights/OptimizeImages
# -colorspace sRGB to preserve colours. Seems to have no effect on file size, so no problem?
$count = 0
$percent = 0
foreach ($arg in $args) {
	$name = $arg.split(".")[0]
	$newname = $name + "_optimised.jpg"
	Write-Progress -Activity "Converting to jpg" -Status "$percent_formatted% Complete:" -PercentComplete $percent;
	magick -quality 85 -interlace JPEG -colorspace sRGB -define jpeg:dct-method=float -sampling-factor 4:2:0 -format jpg $arg $newname
	$count++
	$percent = $count / $args.count * 100
	$percent_formatted = "{0:n1}" -f $percent
}