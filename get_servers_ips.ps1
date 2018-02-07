﻿$servers = get-content "C:\TEMP\servers.txt"
$serversAndIps ="C:\TEMP\servers.csv"

$results = @()
foreach ($server in $servers)
{
    $result = "" | Select ServerName , ipaddress
    $result.ipaddress = [System.Net.Dns]::GetHostAddresses($server)
    $addresses = [System.Net.Dns]::GetHostAddresses($server)

    foreach($a in $addresses) 
    {
        "{0},{1}" -f $server, $a.IPAddressToString
        $result.ipaddress = [System.Net.Dns]::GetHostAddresses($server)
    }

    $result.servername = $server
    $result.ipaddress = $a.IPAddressToString
    $results += $result
}
$results | export-csv -NoTypeInformation $serversandips