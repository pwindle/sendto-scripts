$count = 0
$percent = 0
foreach ($arg in $args) {
	$name = $arg.split(".")[0]
	$newname = $name + "_alpha-off.png"
	Write-Progress -Activity "Removing alpha from images" -Status "$percent_formatted% Complete:" -PercentComplete $percent;
	magick mogrify -alpha off $arg $newname
	$count++
	$percent = $count / $args.count * 100
	$percent_formatted = "{0:n1}" -f $percent
}