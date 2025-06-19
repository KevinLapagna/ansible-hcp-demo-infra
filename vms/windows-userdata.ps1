#ps1_sysnative
# Import the client certificate from base64 (provided by Terraform)
$certBytes = [System.Convert]::FromBase64String("${client_certificate}")
$certPath = "C:\\ProgramData\\aap-client-certificate.crt"
[System.IO.File]::WriteAllBytes($certPath, $certBytes)

# Import certificate to LocalMachine\My store
$cert = Import-PfxCertificate -FilePath $certPath -CertStoreLocation Cert:\LocalMachine\My -Password (ConvertTo-SecureString -String "" -AsPlainText -Force) -Exportable
if (-not $cert) {
    $cert = Import-Certificate -FilePath $certPath -CertStoreLocation Cert:\LocalMachine\My
}

# Enable WinRM HTTPS listener if not present
$winrmPort = 5986
$hostname = (Get-WmiObject Win32_ComputerSystem).Name
$certThumbprint = $cert.Thumbprint
$listener = winrm enumerate winrm/config/Listener | Select-String -Pattern $certThumbprint
if (-not $listener) {
    winrm create winrm/config/Listener?Address=*+Transport=HTTPS @{Hostname="$hostname";CertificateThumbprint="$certThumbprint"}
}

# Enable certificate authentication
winrm set winrm/config/service/auth @{Certificate="true"}

# Map certificate to Administrator
$adminSid = (Get-LocalUser -Name "Administrator").Sid.Value
$mapping = Get-ChildItem -Path WSMan:\localhost\Service\CertificateMapping | Where-Object { $_.Subject -eq $cert.Subject }
if (-not $mapping) {
    New-Item -Path WSMan:\localhost\Service\CertificateMapping -Subject $cert.Subject -Issuer $cert.Issuer -Enabled $true -UserName "Administrator" -Password "" -Uri "*" -CredentialType "Certificate" -UserSid $adminSid
}

# Set WinRM service to start automatically and restart it
Set-Service -Name WinRM -StartupType Automatic
Restart-Service -Name WinRM

# Allow WinRM HTTPS in firewall
if (-not (Get-NetFirewallRule -DisplayName "Allow WinRM HTTPS" -ErrorAction SilentlyContinue)) {
    New-NetFirewallRule -DisplayName "Allow WinRM HTTPS" -Direction Inbound -Protocol TCP -LocalPort $winrmPort -Action Allow
}
