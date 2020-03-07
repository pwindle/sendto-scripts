$algorithm = @('sha256','sha384','sha512')

cls
'' | Write-Host
$algorithm | echo
'' | Write-Host

# Bulk hash
foreach ($arg in $args ) {
	# <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Quicksand" integrity="sha256-wGT93KaGDpZB8TyWF1JczXB2AnLM93S7+xUsOzP+x34= sha384-4cL1VNk7+NJmw/XBgA8Wta/R4hrWRn8dga1f9y8WDaOEB+NuuzRKPXl0+6rd6BCB sha512-NzPfV6suxZk6IidvgMcc3MkYfQDuO9DfbJcQMrEyLK5NM48JOBSf9xOMPIq13biCt7cV0Dh5tu0u1oRoqaRrBg==" crossorigin="anonymous">
	# dl file if matches crude url form
	# perform hash 
	# base64 encode hash
	# 
	$table = (Get-FileHash -a $algorithm $arg)
	if ($null -ne (Get-Clipboard)) {
	if ($table.Hash  -eq (Get-Clipboard).Trim()) {
		"Clipboard match:`n" + (Get-Clipboard).Trim() | Write-Host -ForegroundColor Green
	}
	}
	# $table.Algorithm + ' ' + 
	$table.Hash + ' | ' + 
	($table.Path | split-path -leaf) | echo
}

"`nFolder: " + ($table.Path | split-path -parent) + 
"`n" + $args.length.ToString() + " files hashed`n" | echo

if ($args.length -eq 1) {
	Read-Host "`nPress any key to copy hash to the clipboard"
	$table.Hash | Set-Clipboard
}
