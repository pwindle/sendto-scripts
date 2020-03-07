# remove spaces

$count = 0
$percent = 0
foreach ($arg in $args) {
	$newname = $arg.replace(" ","_")
	Write-Progress -Activity "Removing spaces" -Status "$percent_formatted% Complete:" -PercentComplete $percent;
	Rename-Item "$arg" -NewName $newname
	$count++
	$percent = $count / $args.count * 100
	$percent_formatted = "{0:n1}" -f $percent
}