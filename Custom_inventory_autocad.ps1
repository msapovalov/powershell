#************************DO NOT EDIT********************************
$nse = new-object -comobject Altiris.AeXNSEvent
$nse.priority = 1
$nse.To = "{1592B913-72F3-4C36-91D2-D4EDA21D2F96}"
#************************DO NOT EDIT********************************

#Modify this varaible with the custom data class guid
$objDCInstance = $nse.AddDataClass("{5f939d49-f82a-497f-8d48-025cfe89edae}")

$objDataClass = $nse.AddDataBlock($objDCInstance)

$datafiles = Get-ChildItem -ErrorAction SilentlyContinue HKLM:\SOFTWARE\Autodesk\AutoCAD\|
             Get-ChildItem -ErrorAction SilentlyContinue|
             Get-ItemProperty |
             Where-Object{
             $_.ProductName -like 'AutoCad*'} | select ProductName, Release, SerialNumber, StandaloneNetworkType -ErrorAction SilentlyContinue

#loop through each data file we found and populate rows and columns.
foreach ($datafile in $datafiles)
{
    if (-not (($datafile.Path -like "*Altiris*") -or ($datafile.FileName -like "*Sample*")))
    {
        
        #Add new row of data
        $objDataRow = $objDataClass.AddRow()
        #popluate columns
        $objDataRow.SetField(0, $datafile.ProductName)
        $objDataRow.SetField(1, $datafile.Release)
        $objDataRow.SetField(2, $datafile.SerialNumber.ToString())
        $objDataRow.SetField(3, $datafile.StandaloneNetworkType.ToString())
        
    }
}

#Send the data
$nse.sendqueued()