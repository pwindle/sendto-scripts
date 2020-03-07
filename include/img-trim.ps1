$count = 0
$percent = 0
foreach ($arg in $args) {
	Write-Progress -Activity "Trimming images" -Status "$percent_formatted% Complete:" -PercentComplete $percent;
	magick mogrify -trim $arg
	$count++
	$percent = $count / $args.count * 100
	$percent_formatted = "{0:n1}" -f $percent
}