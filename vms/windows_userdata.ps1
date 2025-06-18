<powershell>
# Windows UserData Script for WinRM Configuration
# This script configures WinRM for Ansible automation

# Set execution policy to allow script execution
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force

# Enable WinRM service
Enable-PSRemoting -Force -SkipNetworkProfileCheck

# Configure WinRM settings
winrm quickconfig -quiet
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service/auth '@{CredSSP="true"}'
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="2048"}'
winrm set winrm/config/winrs '@{MaxProcessesPerShell="50"}'
winrm set winrm/config/winrs '@{MaxShellsPerUser="50"}'

# Configure HTTPS listener (self-signed certificate)
$cert = New-SelfSignedCertificate -DnsName $env:COMPUTERNAME -CertStoreLocation Cert:\LocalMachine\My
winrm create winrm/config/Listener?Address=*+Transport=HTTPS "@{Hostname=`"$env:COMPUTERNAME`";CertificateThumbprint=`"$($cert.Thumbprint)`"}"

# Set Windows Firewall rules for WinRM
New-NetFirewallRule -DisplayName "WinRM HTTP" -Direction Inbound -Protocol TCP -LocalPort 5985 -Action Allow
New-NetFirewallRule -DisplayName "WinRM HTTPS" -Direction Inbound -Protocol TCP -LocalPort 5986 -Action Allow

# Configure Administrator password (for demo purposes)
$AdminPassword = "${admin_password}"
$SecurePassword = ConvertTo-SecureString $AdminPassword -AsPlainText -Force
$AdminUser = [ADSI]"WinNT://./Administrator,user"
$AdminUser.SetPassword($AdminPassword)
$AdminUser.SetInfo()

# Enable Administrator account
net user Administrator /active:yes

# Configure PowerShell execution policy for all users
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine -Force

# Disable UAC for smoother automation (demo environment only)
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Value 0

# Disable Windows Defender for demo environment (optional)
Set-MpPreference -DisableRealtimeMonitoring $true -ErrorAction SilentlyContinue

# Configure network profile to Private (allows WinRM)
Get-NetConnectionProfile | Set-NetConnectionProfile -NetworkCategory Private

# Set timezone to UTC for consistency
tzutil /s "UTC"

# Create a log file to verify script execution
$LogFile = "C:\Windows\Temp\winrm_setup.log"
$LogContent = @"
WinRM Configuration Completed at: $(Get-Date)
Computer Name: $env:COMPUTERNAME
IP Address: $(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -notlike "*Loopback*"} | Select-Object -First 1).IPAddress
WinRM HTTP Port: 5985
WinRM HTTPS Port: 5986
Administrator Password: ${admin_password}

Test WinRM connectivity with:
winrs -r:http://[IP]:5985 -u:Administrator -p:${admin_password} cmd

For Ansible inventory:
[windows]
[IP] ansible_user=Administrator ansible_password=${admin_password} ansible_connection=winrm ansible_winrm_transport=basic ansible_winrm_server_cert_validation=ignore
"@

$LogContent | Out-File -FilePath $LogFile -Encoding UTF8

# Restart WinRM service to ensure all settings are applied
Restart-Service WinRM

Write-Host "WinRM configuration completed successfully!"
Write-Host "Log file created at: $LogFile"
</powershell>
