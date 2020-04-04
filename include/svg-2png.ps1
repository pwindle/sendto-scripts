$width = Read-Host -Prompt 'Give the desired width of the png (e.g 1024)'


$count = 0
$percent = 0
foreach ($arg in $args) {
	$name = $arg.split(".")[0]
	$newname = $name + ".png"
	Write-Progress -Activity "Converting svg to png" -Status "$percent_formatted% Complete:" -PercentComplete $percent;
	inkscape -z -e $newname -w $width $arg
	$count++
	$percent = $count / $args.count * 100
	$percent_formatted = "{0:n1}" -f $percent
}