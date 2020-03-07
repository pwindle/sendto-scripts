$algorithm = 'sha512'

cls
'' | Write-Host
$algorithm | echo
'' | Write-Host

# Bulk hash
foreach ($arg in $args ) {
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
