$LapsAdminRemediationLogPath = "c:\ProgramData\Microsoft\IntuneManagementExtension\Logs\lapsadminremediate.log"

try {
    Start-Transcript -path "$LapsAdminRemediationLogPath"
} catch {
      Start-Transcript -path "$LapsAdminRemediationLogPath"
}

Add-Type -AssemblyName 'System.Web'

$userParams = @{
    Name = 'lapsadmin'
    Description = 'LAPS Client Admin'
    Password = [System.Web.Security.Membership]::GeneratePassword(16, 0) | ConvertTo-SecureString -AsPlainText -Force
}

# create user with random password
try {
    New-LocalUser @userParams -ErrorAction Stop
} catch [Microsoft.PowerShell.Commands.UserExistsException] {
    Write-Output $_.Exception.Message
}

# Add user to built-in administrators group
try {
    Add-LocalGroupMember -SID 'S-1-5-32-544' -Member ($userParams).Name -ErrorAction Stop
} catch [Microsoft.PowerShell.Commands.MemberExistsException] {
    Write-Output $_.Exception.Message
}

Stop-Transcript
