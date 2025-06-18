<powershell>
# Windows Server 2022 WinRM Configuration with Certificate Authentication
# This script configures WinRM to accept certificate-based authentication

Write-Output "Starting WinRM configuration for certificate authentication"

# Enable WinRM service
Enable-PSRemoting -Force
Set-Service WinRM -StartupType Automatic
Start-Service WinRM

# Configure WinRM service settings
winrm quickconfig -quiet
winrm set winrm/config/service '@{AllowUnencrypted="false"}'
winrm set winrm/config/service/auth '@{Basic="false";Kerberos="false";Negotiate="false";Certificate="true";CredSSP="false"}'
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="1024"}'

# Create HTTPS listener with self-signed certificate if it doesn't exist
$httpsListener = winrm enumerate winrm/config/listener | Select-String "HTTPS"
if (-not $httpsListener) {
    Write-Output "Creating HTTPS listener for WinRM"
    
    # Create self-signed certificate for WinRM HTTPS
    $cert = New-SelfSignedCertificate -DnsName $env:COMPUTERNAME -CertStoreLocation Cert:\LocalMachine\My
    $thumbprint = $cert.Thumbprint
    
    # Create HTTPS listener
    winrm create winrm/config/Listener?Address=*+Transport=HTTPS "@{Hostname=`"$env:COMPUTERNAME`";CertificateThumbprint=`"$thumbprint`"}"
    
    Write-Output "HTTPS listener created with certificate thumbprint: $thumbprint"
}

# Configure Windows Firewall for WinRM HTTPS only
New-NetFirewallRule -DisplayName "Windows Remote Management (HTTPS-In)" -Direction Inbound -Protocol TCP -LocalPort 5986 -Action Allow -ErrorAction SilentlyContinue

# Disable Windows Firewall rule for HTTP WinRM (if it exists)
Remove-NetFirewallRule -DisplayName "Windows Remote Management (HTTP-In)" -ErrorAction SilentlyContinue

# Import the client certificate into the Trusted Root Certification Authorities store
try {
    Write-Output "Importing client certificate for certificate authentication"
    
    # Decode the base64 certificate
    $clientCertB64 = "${client_certificate}"
    $clientCertBytes = [System.Convert]::FromBase64String($clientCertB64)
    
    # Create certificate object
    $clientCert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
    $clientCert.Import($clientCertBytes)
    
    # Import into Trusted Root store (required for certificate authentication)
    $store = New-Object System.Security.Cryptography.X509Certificates.X509Store("Root", "LocalMachine")
    $store.Open([System.Security.Cryptography.X509Certificates.OpenFlags]::ReadWrite)
    $store.Add($clientCert)
    $store.Close()
    
    Write-Output "Client certificate imported successfully"
    Write-Output "Certificate Subject: $($clientCert.Subject)"
    Write-Output "Certificate Thumbprint: $($clientCert.Thumbprint)"
    
    # Create local user mapping for certificate authentication
    # Extract CN from certificate subject
    $subjectParts = $clientCert.Subject -split ','
    $cn = ($subjectParts | Where-Object { $_ -like "*CN=*" }).Split('=')[1].Trim()
    
    Write-Output "Creating certificate mapping for CN: $cn"
    
    # Map certificate to Administrator account
    $adminSid = (Get-LocalUser -Name "Administrator").SID.Value
    winrm create winrm/config/service/certmapping "@{Subject=`"$($clientCert.Subject)`";URI=`"*`";Issuer=`"$($clientCert.Issuer)`";UserName=`"Administrator`";Password=`"`"}"
    
} catch {
    Write-Output "Error importing certificate: $($_.Exception.Message)"
}

# Configure Local Security Policy for certificate authentication
Write-Output "Configuring Local Security Policy for certificate authentication"

# Disable password authentication completely
winrm set winrm/config/service/auth '@{Basic="false";Kerberos="false";Negotiate="false";Certificate="true";CredSSP="false"}'

# Ensure only HTTPS connections are allowed
winrm set winrm/config/service '@{AllowUnencrypted="false"}'

# Set additional security settings
winrm set winrm/config/service '@{MaxConcurrentOperationsPerUser="4294967295"}'
winrm set winrm/config/service '@{EnumerationTimeoutms="240000"}'
winrm set winrm/config/service '@{MaxPacketRetrievalTimeSeconds="120"}'

# Enable certificate authentication in Local Security Policy
secedit /export /cfg C:\Windows\Temp\secconfig.cfg
(Get-Content C:\Windows\Temp\secconfig.cfg) -replace 'SeDenyNetworkLogonRight = Guest', 'SeDenyNetworkLogonRight = Guest' | Set-Content C:\Windows\Temp\secconfig.cfg
secedit /configure /db secedit.sdb /cfg C:\Windows\Temp\secconfig.cfg

# Restart WinRM service to apply changes
Restart-Service WinRM -Force

Write-Output "WinRM configuration completed"
Write-Output "WinRM HTTP port: 5985 (disabled for unencrypted traffic)"
Write-Output "WinRM HTTPS port: 5986"
Write-Output "Certificate authentication: Enabled (ONLY)"
Write-Output "Password authentication: Disabled"

# Display WinRM configuration
winrm get winrm/config

Write-Output "Windows Server configuration completed successfully!"
</powershell>
