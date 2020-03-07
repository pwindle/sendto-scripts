$rotate = Read-Host -Prompt 'Enter the degrees of rotation clockwise'
$count = 0
$percent = 0
foreach ($arg in $args) {
	Write-Progress -Activity "Rotating images" -Status "$percent_formatted% Complete:" -PercentComplete $percent;
	magick mogrify -background 'rgba(0,0,0,0)' -rotate $rotate $arg
	$count++
	$percent = $count / $args.count * 100
	$percent_formatted = "{0:n1}" -f $percent
}