foreach ($arg in $args) {
	$name = $arg.split(".")[0]
	$newname = $name + ".html"
	$arg | Import-Csv | ConvertTo-Html | Out-File -FilePath $newname
}