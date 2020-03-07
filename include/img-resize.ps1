$greaterSide = Read-Host -Prompt 'Give the longer side of the desired resolution (aspect ratio will be maintained)'
$resizeString = $greaterSide + "x" + $greaterSide
$count = 0
$percent = 0
foreach ($arg in $args) {
	Write-Progress -Activity "Resizing images" -Status "$percent_formatted% Complete:" -PercentComplete $percent;
	magick mogrify -resize $resizeString $arg
	$count++
	$percent = $count / $args.count * 100
	$percent_formatted = "{0:n1}" -f $percent
}