

$count = 0
$percent = 0
foreach ($arg in $args) {
	$name = $arg.Substring(0, $arg.LastIndexOf('.'))
	$newname = $name + ".srt"
	Write-Progress -Activity "Converting to srt" -Status "$percent_formatted% Complete:" -PercentComplete $percent;
	Invoke-Expression "ffmpeg -i '$arg' '$newname'"
	$count++
	$percent = $count / $args.count * 100
	$percent_formatted = "{0:n1}" -f $percent
}