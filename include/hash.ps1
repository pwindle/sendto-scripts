$algorithm = Read-Host 'Type the desired algorithm. Valid options are:

    SHA1
    SHA256
    SHA384
    SHA512
    MD5

> '

if (($algorithm -eq "sha512") -or 
    ($algorithm -eq "sha384")) {
	[console]::WindowWidth=192
	[console]::BufferWidth=[console]::WindowWidth
}

cls
'' | Write-Host
$algorithm | echo
'' | Write-Host

# Bulk hash
foreach ($arg in $args ) {
	$table = (Get-FileHash -a $algorithm $arg)
	if ($null -ne (Get-Clipboard)) {
	if ($table.Hash -eq (Get-Clipboard).Trim()) {
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
	$table.Hash | Set-Clipboard
	Write-Host "`nHash copied to clipboard"
}

Read-Host