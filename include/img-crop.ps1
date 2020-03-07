$region = Read-Host -Prompt 'Give a region (e.g 100x100 or just 100 for a square)'
if ( $region.contains('x') -eq $false ) { $region = $region + "x" + $region }
if ( $region.contains('+') -eq $false ) { $region = $region + "+0+0" }

$gravity = Read-Host -Prompt 'Choose a gravity: Center, Forget, NorthWest, North, NorthEast, West, East, SouthWest, South, SouthEast (default center)'
if ( $gravity -eq '') { $gravity = 'center' }

$count = 0
$percent = 0
foreach ($arg in $args) {
	Write-Progress -Activity "Cropping and centering images" -Status "$percent_formatted% Complete:" -PercentComplete $percent;
	magick mogrify -crop $region -gravity $gravity $arg
	$count++
	$percent = $count / $args.count * 100
	$percent_formatted = "{0:n1}" -f $percent
}