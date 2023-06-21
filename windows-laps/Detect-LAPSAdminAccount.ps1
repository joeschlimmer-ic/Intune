$LapsAdminDetectionLogPath = "c:\ProgramData\Microsoft\IntuneManagementExtension\Logs\lapsadmindetection.log"

try {
    Start-Transcript -path "$LapsAdminDetectionLogPath"
} catch {
    Start-Transcript -path "$LapsAdminDetectionLogPath"
}

$username = "lapsadmin"
try {
    $user = Get-LocalUser -Name $username -ErrorAction Stop
    if ($user.Enabled) {
        Write-Output ("User {0} present and enabled" -f $username)
        exit 0
    }
    else {
        Write-Output ("User {0} present but NOT enabled" -f $username)
        Exit 1 
    }
}
catch {
    Write-Output ("User {0} not found" -f $username)
    Exit 1
}

Stop-Transcript