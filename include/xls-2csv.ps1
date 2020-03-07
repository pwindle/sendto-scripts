# Get COM Object
$oExcel = New-Object -ComObject "Excel.Application"
# Should Excel be visible?
$oExcel.Visible = $false

foreach ($arg in $args) {
	
	
	$name = $arg.split(".")[0]
	$newname = $name + ".csv"
	
	$sExcelFile=$arg
	$sCSVFile=$newname
	
	# and open excel file
	$oExcelDoc = $oExcel.Workbooks.Open($sExcelFile)
	
	# Open 1st Worksheet
	$oWorksheet = $oExcelDoc.Worksheets.item(1)
	# # Activate, show it
	# $oWorksheet.Activate()
	
	$oExcelDoc.SaveAs($sCSVFile,[Microsoft.Office.Interop.Excel.XlFileFormat]::xlCSVWindows)
	
}

$oEexcel.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($oExcel)
# no $ needed on variable name in Remove-Variable call
Remove-Variable oExcel