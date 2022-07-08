#EXAMPLE
$File1 =  "C:\temp\COMPARE\tbl18_BC202_FullExtensions.txt"  #NEW
$File2 =  "C:\temp\COMPARE\tbl18_NAV2009_All.txt"           #OLD
$Location = "C:\temp\COMPARE\Differencestbl18.txt"          #DIFFERENCES

#EXAMPLE
$File1 =  "C:\temp\COMPARE\tbl287_BC202_FullExtensions.txt"  #NEW
$File2 =  "C:\temp\COMPARE\tbl287_NAV2009.txt"               #OLD
$Location = "C:\temp\COMPARE\Differencestbl287.txt"          #DIFFERENCES


#OBJECT COMPARE
Compare-Object -referenceObject $(Get-Content $File1) -differenceObject $(Get-Content $File2) | ft -auto | out-file $Location -Verbose ascii 
