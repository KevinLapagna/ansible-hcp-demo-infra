#ps1_sysnative
# Set Administrator password for debugging
$adminPassword = "P@ssw0rd123!"  # Static password for debugging
net user Administrator $adminPassword /active:yes

# Enable RDP
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Import the client certificate from base64 (provided by Terraform)
$certBytes = [System.Convert]::FromBase64String("${client_certificate}")
$certPath = "C:\\ProgramData\\aap-client-certificate.crt"
[System.IO.File]::WriteAllBytes($certPath, $certBytes)

# Import certificate to LocalMachine\My store
$cert = Import-PfxCertificate -FilePath $certPath -CertStoreLocation Cert:\LocalMachine\My -Password (ConvertTo-SecureString -String "" -AsPlainText -Force) -Exportable
if (-not $cert) {
    $cert = Import-Certificate -FilePath $certPath -CertStoreLocation Cert:\LocalMachine\My
}

# Configure WinRM
winrm quickconfig -q
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service/auth '@{Certificate="true"}'
winrm set winrm/config/client '@{AllowUnencrypted="true"}'

# Enable WinRM HTTP listener (5985) for debugging
$httpListener = winrm enumerate winrm/config/Listener | Select-String -Pattern "Address = \*" | Select-String -Pattern "Transport = HTTP"
if (-not $httpListener) {
    winrm create winrm/config/Listener?Address=*+Transport=HTTP
}

# Enable WinRM HTTPS listener (5986) if not present
$winrmPort = 5986
$hostname = (Get-WmiObject Win32_ComputerSystem).Name
$certThumbprint = $cert.Thumbprint
$httpsListener = winrm enumerate winrm/config/Listener | Select-String -Pattern $certThumbprint
if (-not $httpsListener) {
    winrm create winrm/config/Listener?Address=*+Transport=HTTPS @{Hostname="$hostname";CertificateThumbprint="$certThumbprint"}
}

# Map certificate to Administrator
$adminSid = (Get-LocalUser -Name "Administrator").Sid.Value
$mapping = Get-ChildItem -Path WSMan:\localhost\Service\CertificateMapping | Where-Object { $_.Subject -eq $cert.Subject }
if (-not $mapping) {
    New-Item -Path WSMan:\localhost\Service\CertificateMapping -Subject $cert.Subject -Issuer $cert.Issuer -Enabled $true -UserName "Administrator" -Password "" -Uri "*" -CredentialType "Certificate" -UserSid $adminSid
}

# Set WinRM service to start automatically and restart it
Set-Service -Name WinRM -StartupType Automatic
Restart-Service -Name WinRM

# Allow WinRM in firewall (both HTTP and HTTPS)
if (-not (Get-NetFirewallRule -DisplayName "Allow WinRM HTTP" -ErrorAction SilentlyContinue)) {
    New-NetFirewallRule -DisplayName "Allow WinRM HTTP" -Direction Inbound -Protocol TCP -LocalPort 5985 -Action Allow
}
if (-not (Get-NetFirewallRule -DisplayName "Allow WinRM HTTPS" -ErrorAction SilentlyContinue)) {
    New-NetFirewallRule -DisplayName "Allow WinRM HTTPS" -Direction Inbound -Protocol TCP -LocalPort $winrmPort -Action Allow
}

# Create a log file to confirm script execution
"Windows configuration completed at $(Get-Date)" | Out-File -FilePath "C:\windows-setup.log"
