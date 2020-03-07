$grid = Read-Host -Prompt 'Give a grid (e.g 4x2 for 8 tiles 4 across 2 up)'
$grid = $grid + "@"

$count = 0
$percent = 0
foreach ($arg in $args) {
	$name = $arg.split(".")[0]
	$newname = $name + "-tile.png"
	Write-Progress -Activity "Cutting image into tiles" -Status "$percent_formatted% Complete:" -PercentComplete $percent;
	magick $arg -crop $grid $newname
	$count++
	$percent = $count / $args.count * 100
	$percent_formatted = "{0:n1}" -f $percent
}