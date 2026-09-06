$ErrorActionPreference = 'Stop'

Write-Host 'Checking ADB device...'
adb devices

Write-Host ''
Write-Host 'Clearing previous logcat...'
adb logcat -c

Write-Host ''
Write-Host 'Now connect the phone to the AV-1298 with USB and open Android Auto.'
Read-Host 'Press ENTER after Android Auto is connected'

$out = Join-Path $PSScriptRoot 'android-auto-av1298-log.txt'

Write-Host 'Collecting relevant logs for 20 seconds...'
$job = Start-Job -ScriptBlock {
    adb logcat -v time | Select-String -Pattern 'FermataAV1298|CAR.AUTH|isPackageAllowed|PlayGearhead|Finsky|AndroidAuto|Gearhead|fermata'
}
Start-Sleep -Seconds 20
Stop-Job $job
Receive-Job $job | Out-File -Encoding utf8 $out
Remove-Job $job

Write-Host ''
Write-Host "Saved diagnostic log to: $out"
Write-Host 'Look for FermataAV1298 startup lines and any CAR.AUTH / isPackageAllowed rejection.'
