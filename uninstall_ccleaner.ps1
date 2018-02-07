<# 
.SYNOPSIS 
	Uninstall Ccleaner
 
.DESCRIPTION 
	Script will show user a message box and uninstalls CCleaner
 
.NOTES 
┌─────────────────────────────────────────────────────────────────────────────────────────────┐ 
│ ORIGIN STORY                                                                                │ 
├─────────────────────────────────────────────────────────────────────────────────────────────┤ 
│   DATE        : 2017.22.11
│   AUTHOR      : Mihhail_Shapovalov
│   DESCRIPTION : Release
└─────────────────────────────────────────────────────────────────────────────────────────────┘ 
 
.PARAMETER Param01 
 
.PARAMETER Param02 
 
.EXAMPLE 

#> 

# Load assembly
[void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') 

$file = 'C:\Program Files\CCleaner\uninst.exe'

if (-NOT (Test-Path $file)) {exit(0)}


Else {
Do {if([Microsoft.VisualBasic.Interaction]::MsgBox(" We found a vulnerable CCleaner application installed on your computer.`n We need to uninstall it immediately. `n Thank you.",'OKOnly,Information',"Your IT") -eq 'OK'){
            Start-Process -FilePath $file -Wait
	    } 
	   }
Until (-NOT (Test-Path $file))

if([Microsoft.VisualBasic.Interaction]::MsgBox(" CCleaner  have been successfully uninstalled. `n Thank you.",'OKOnly,Information'," Symantec IT") -eq 'OK'){
            exit(0)}}
