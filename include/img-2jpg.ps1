
# settings from comment thread on this stackoverflow answer: https://stackoverflow.com/a/7262050
# and as recommended by google for optimisation: https://developers.google.com/speed/docs/insights/OptimizeImages
# -colorspace sRGB to preserve colours. Seems to have no effect on file size, so no problem?

$quality = Read-Host -Prompt 'Give quality setting (1-100, default 85) '
if ($quality -eq "") { $quality = 85 }
$count = 0
$percent = 0
foreach ($arg in $args) {
	Write-Progress -Activity "Converting to jpg" -Status "$percent_formatted% Complete:" -PercentComplete $percent;
	magick mogrify -quality $quality -interlace Plane -colorspace sRGB -define jpeg:dct-method=float -sampling-factor 4:2:0 -format jpg $arg
	$count++
	$percent = $count / $args.count * 100
	$percent_formatted = "{0:n1}" -f $percent
}