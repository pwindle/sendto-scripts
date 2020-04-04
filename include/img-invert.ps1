$count = 0
$percent = 0
foreach ($arg in $args) {
	Write-Progress -Activity "Inverting images" -Status "$percent_formatted% Complete:" -PercentComplete $percent;
	magick mogrify -channel RGB -negate $rotate $arg
	$count++
	$percent = $count / $args.count * 100
	$percent_formatted = "{0:n1}" -f $percent
}