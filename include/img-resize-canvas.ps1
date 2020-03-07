$width  = Read-Host -Prompt 'Give the new width'
$height = Read-Host -Prompt 'Give the new height'
$colour = Read-Host -Prompt 'Give the background colour (defualt transparent)'
$resizeString = $width + "x" + $height
if ($colour -eq "") { $colour = "none" }
$count = 0
$percent = 0
foreach ($arg in $args) {
	Write-Progress -Activity "Resizing images" -Status "$percent_formatted% Complete:" -PercentComplete $percent;
	magick mogrify -resize $resizeString -background $colour -gravity center -extent $resizeString $arg
	$count++
	$percent = $count / $args.count * 100
	$percent_formatted = "{0:n1}" -f $percent
}