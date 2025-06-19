<powershell>
# Basic WinRM Setup for Windows Server 2022
# This script enables WinRM with basic authentication first, then adds certificate support

Write-Host "Starting basic WinRM setup..."


# Enable WinRM
Write-Host "Enabling WinRM..."
Enable-PSRemoting -Force -SkipNetworkProfileCheck

# Configure WinRM for remote access
winrm quickconfig -quiet

# Enable basic authentication (for initial setup)
winrm set winrm/config/service/auth '@{Basic="true"}'

# Allow unencrypted (for HTTP debugging)
winrm set winrm/config/service '@{AllowUnencrypted="true"}'

# Enable certificate authentication
winrm set winrm/config/service/auth '@{Certificate="true"}'

# Set maximum timeout
winrm set winrm/config '@{MaxTimeoutms="1800000"}'

# Configure shell memory
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="2048"}'

# Import the client certificate
Write-Host "Importing client certificate..."

$certContent = @"
${certificate_content}
"@

$certFile = "C:\temp\client-cert.crt"
New-Item -Path "C:\temp" -ItemType Directory -Force
$certContent | Out-File -FilePath $certFile -Encoding ASCII

# Check if client certificate already exists
$existingCert = Get-ChildItem -Path Cert:\LocalMachine\TrustedPeople | Where-Object { $_.Subject -eq "CN=Administrator" }
if ($existingCert) {
    Write-Host "Client certificate already exists with thumbprint: $($existingCert.Thumbprint)"
    $cert = $existingCert
} else {
    # Import to both stores
    $cert = Import-Certificate -FilePath $certFile -CertStoreLocation Cert:\LocalMachine\TrustedPeople
    Import-Certificate -FilePath $certFile -CertStoreLocation Cert:\LocalMachine\Root
    Write-Host "Certificate imported with thumbprint: $($cert.Thumbprint)"
}

# Check if self-signed certificate for HTTPS already exists
$existingSelfSigned = Get-ChildItem -Path Cert:\LocalMachine\My | Where-Object { $_.Subject -eq "CN=localhost" }
if ($existingSelfSigned) {
    Write-Host "Self-signed certificate already exists with thumbprint: $($existingSelfSigned.Thumbprint)"
    $selfSignedCert = $existingSelfSigned
} else {
    # Create a self-signed certificate for HTTPS listener
    Write-Host "Creating self-signed certificate for HTTPS listener..."
    $selfSignedCert = New-SelfSignedCertificate -DnsName "localhost" -CertStoreLocation "Cert:\LocalMachine\My" -KeyUsage DigitalSignature,KeyEncipherment -KeyAlgorithm RSA -KeyLength 2048
    Write-Host "Self-signed certificate created with thumbprint: $($selfSignedCert.Thumbprint)"
}

# Check if HTTPS listener already exists
Write-Host "Checking for existing HTTPS listener..."
$existingListener = winrm enumerate winrm/config/listener | Select-String "Transport = HTTPS"
if (-not $existingListener) {
    # Create HTTPS listener for WinRM using the self-signed certificate
    Write-Host "Creating HTTPS listener for WinRM..."
    $httpsThumbprint = $selfSignedCert.Thumbprint
    winrm create winrm/config/Listener?Address=*+Transport=HTTPS "@{Hostname=`"localhost`";CertificateThumbprint=`"$httpsThumbprint`"}"
} else {
    Write-Host "HTTPS listener already exists"
}

# Set Administrator password (required before certificate mapping)
Write-Host "Setting Administrator password for certificate mapping..."

# Generate a secure random password using .NET crypto
Add-Type -AssemblyName 'System.Web'
$randomPassword = [System.Web.Security.Membership]::GeneratePassword(16, 4)
Write-Host "Generated random password for Administrator account"

# Set the Administrator password
net user Administrator $randomPassword /active:yes

# Create certificate mapping using PowerShell method (Ansible-compatible)
Write-Host "Setting up certificate mapping for Ansible compatibility..."

# Get the userPrincipalName from the certificate SAN field
$userPrincipalName = $cert.GetNameInfo('UpnName', $false)
Write-Host "Certificate UPN: $userPrincipalName"

# Build certificate chain to get the CA thumbprint
$certChain = [System.Security.Cryptography.X509Certificates.X509Chain]::new()
[void]$certChain.Build($cert)
$caThumbprint = $certChain.ChainElements.Certificate[-1].Thumbprint
Write-Host "CA Thumbprint: $caThumbprint"

# Check if certificate mapping already exists
$existingMappings = Get-ChildItem -Path WSMan:\localhost\ClientCertificate -ErrorAction SilentlyContinue | 
    Where-Object {
        $mapping = $_ | Get-Item
        "Subject=$userPrincipalName" -in $mapping.Keys
    }

if ($existingMappings) {
    Write-Host "Certificate mapping already exists for $userPrincipalName"
} else {
    # Create the certificate mapping using the random password
    Write-Host "Creating certificate mapping for $userPrincipalName..."
    
    # Create credential object with the random password
    $securePassword = ConvertTo-SecureString $randomPassword -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential("Administrator", $securePassword)
    
    # Create the certificate mapping
    $certMapping = @{
        Path       = 'WSMan:\localhost\ClientCertificate'
        Subject    = $userPrincipalName
        Issuer     = $caThumbprint
        Credential = $credential
        Force      = $true
    }
    
    try {
        New-Item @certMapping
        Write-Host "Certificate mapping created successfully"
    } catch {
        Write-Host "Error creating certificate mapping: $($_.Exception.Message)"
    }
}

# Configure firewall (these commands are idempotent)
Write-Host "Configuring firewall..."
netsh advfirewall firewall set rule group="Windows Remote Management" new enable=yes 2>$null
netsh advfirewall firewall add rule name="WinRM-HTTP" dir=in localport=5985 protocol=TCP action=allow 2>$null
netsh advfirewall firewall add rule name="WinRM-HTTPS" dir=in localport=5986 protocol=TCP action=allow 2>$null

# Enable RDP
Write-Host "Enabling RDP..."
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
netsh advfirewall firewall add rule name="Remote Desktop" dir=in localport=3389 protocol=TCP action=allow

# Restart WinRM
Write-Host "Restarting WinRM service..."
net stop winrm
net start winrm

# Test WinRM
Write-Host "Testing WinRM..."
# Enable unencrypted traffic for client to test
winrm set winrm/config/client '@{AllowUnencrypted="true"}'
winrm id -r:http://localhost:5985 -auth:basic -u:Administrator -p:"P@ssw0rd123!"

Write-Host "WinRM setup completed successfully!"

# Add comprehensive diagnostics
Write-Host "`n=== WinRM Configuration Diagnostics ==="
Write-Host "Available Listeners:"
winrm enumerate winrm/config/listener

Write-Host "`nCertificate Mappings:"
Get-ChildItem -Path WSMan:\localhost\ClientCertificate -ErrorAction SilentlyContinue | ForEach-Object {
    $mapping = $_ | Get-Item
    Write-Host "Mapping: $($_.Name)"
    $mapping.Keys | ForEach-Object { Write-Host "  $_" }
}

Write-Host "`nImported Client Certificate Details:"
Write-Host "Subject: $($cert.Subject)"
Write-Host "Issuer: $($cert.Issuer)" 
Write-Host "Thumbprint: $($cert.Thumbprint)"
Write-Host "UPN from SAN: $($cert.GetNameInfo('UpnName', $false))"

Write-Host "`nCertificates in TrustedPeople store:"
Get-ChildItem -Path Cert:\LocalMachine\TrustedPeople | Select-Object Subject, Thumbprint, Issuer | Format-Table

Write-Host "`nNetwork Listeners:"
netstat -an | findstr ":5985\|:5986"

Write-Host "`nWinRM Service Auth Configuration:"
winrm get winrm/config/service/auth

# Cleanup
Remove-Item $certFile -Force -ErrorAction SilentlyContinue


Write-Host "Setup finished. WinRM should be accessible on ports 5985 (HTTP) and 5986 (HTTPS)"
</powershell>
