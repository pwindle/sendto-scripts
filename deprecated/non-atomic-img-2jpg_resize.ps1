# most settings from comment thread on this stackoverflow answer: https://stackoverflow.com/a/7262050
# -colorspace sRGB to preserve colours. Seems to have no effect on file size, so no problem?
$greaterSide = Read-Host -Prompt 'Give the longer side of the desired resolution (aspect ratio will be maintained)'
$resizeString = $greaterSide + "x" + $greaterSide
$count = 0
$percent = 0
foreach ($arg in $args) {
	Write-Progress -Activity "Converting to jpg and resizing" -Status "$percent_formatted% Complete:" -PercentComplete $percent;
	magick mogrify -quality 85 -interlace Plane -colorspace sRGB -define jpeg:dct-method=float -sampling-factor 4:2:0 -resize $resizeString -format jpg $arg
	$count++
	$percent = $count / $args.count * 100
	$percent_formatted = "{0:n1}" -f $percent
}