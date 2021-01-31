$filetype = Read-Host "Enter the desired output file type"

# Ask for quality if applicable
function GetDesiredQuality()
{
	$quality = Read-Host -Prompt 'Give quality setting (1-100, default 85) '
	if ($quality -eq "") { $quality = 85 }
	return $quality
}

$command = "" 

# Set command string
switch ($filetype)
{
	"jpg"   { $quality = GetDesiredQuality; $command = "-quality $quality -interlace Plane -colorspace sRGB -define jpeg:dct-method=float -sampling-factor 4:2:0"; break }
	"webp"  { $quality = GetDesiredQuality; $command = "-quality $quality"; break }
	"png"   { $command = "-interlace Plane -colorspace sRGB"; break }
	
	# settings from comment thread on this stackoverflow answer: https://stackoverflow.com/a/7262050
	# and as recommended by google for optimisation: https://developers.google.com/speed/docs/insights/OptimizeImages
	# -colorspace sRGB to preserve colours. Seems to have no effect on file size, so no problem?
}

$count = 0
$percent = 0
foreach ($arg in $args) {
	$name = $arg.Substring(0, $arg.LastIndexOf('.'))
	$newname = $name + ".$filetype"
	Write-Progress -Activity "Converting to $filetype" -Status "$percent_formatted% Complete:" -PercentComplete $percent;
	Invoke-Expression "magick convert '$arg' $command '$newname'"
	$count++
	$percent = $count / $args.count * 100
	$percent_formatted = "{0:n1}" -f $percent
}