Function Find-Hosts {
param ($path)

$Result = @()

$mails =  Import-Csv $path | ForEach-Object {
 
 $mail = $_.mails
 $userresult = try {((Get-ADUser -Filter "EmailAddress -like '$mail'" -Properties mailNickname).mailNickname)} catch { $null }
 
 if ($userresult -ne $null){
 $req = "$("SYMC\")$($userresult)"
 $Lastlogonhosts = $(try {Get-ADComputer -filter {Info -like $req} -properties Name} catch {$null}) | ForEach-Object {
 $Result += New-Object psobject -Property @{
            Username = $req
            Hostname = $_.Name
            }
        }
        } 
 else {
 $Result += New-Object psobject -Property @{
            Username = "NOT FOUND $mail"  
            Hostname = "EMAIL NOT IN AD"
            }
    }
  
   }
    
$Result | Select Username, Hostname | ft 
$Result | Select Username, Hostname | Export-Csv "C:\Temp\result.csv" -NoTypeInformation
 }

 