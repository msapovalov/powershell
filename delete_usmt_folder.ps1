$scanstate = Get-Process scanstate -ErrorAction SilentlyContinue
if ($scanstate) {
  # try gracefully first
  $scanstate.CloseMainWindow()
  # kill after five seconds
  Sleep 5
  if (!$scanstate.HasExited) {
    $scanstate | Stop-Process -Force
  }
}
Remove-Variable scanstate

$crashplanprocess = Get-Process CrashPlanService -ErrorAction SilentlyContinue
if ($crashplanprocess) {
  # try gracefully first
  $crashplanprocess.CloseMainWindow()
  # kill after five seconds
  Sleep 5
  if (!$crashplanprocess.HasExited) {
    $crashplanprocess | Stop-Process -Force
  }
}
Remove-Variable crashplanprocess

$crashplandesktop = Get-Process CrashPlanDesktop -ErrorAction SilentlyContinue
if ($crashplandesktop) {
  # try gracefully first
  $crashplandesktop.CloseMainWindow()
  # kill after five seconds
  Sleep 5
  if (!$crashplandesktop.HasExited) {
    $crashplandesktop | Stop-Process -Force
  }
}
Remove-Variable crashplandesktop

$crashplanservice = Get-Service CrashPlanService -ErrorAction SilentlyContinue
if ($crashplanservice) {
    $crashplanservice | Stop-Service -Force
  }


$USMTfolder = "$Env:ProgramData\Crashplan\user_settings"
if(Test-Path $USMTfolder)
{
    Remove-Item "$USMTfolder*" -Recurse -Force -ErrorAction Ignore
}

$CrashplanUSMT = "$Env:ProgramFiles\CrashPlan\USMT"

if(Test-Path $CrashplanUSMT)
{
    Remove-Item "$CrashplanUSMT*" -Recurse -Force -ErrorAction Ignore
}

$crashplanservice | Start-Service
Remove-Variable crashplanservice
