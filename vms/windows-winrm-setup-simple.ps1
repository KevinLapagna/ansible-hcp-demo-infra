<powershell>
# Simplified Windows WinRM Certificate Authentication Setup Script
# This script focuses on essential WinRM configuration with robust error handling

# Create log file
$logFile = "C:\Windows\Temp\winrm-setup-simple.log"
Start-Transcript -Path $logFile -Append

Write-Host "Starting simplified WinRM certificate authentication configuration..."

try {
    # Enable WinRM service
    Write-Host "Enabling WinRM service..."
    Enable-PSRemoting -Force -SkipNetworkProfileCheck
    
    # Start and set WinRM service to automatic
    Set-Service -Name WinRM -StartupType Automatic
    Start-Service -Name WinRM
    
    Write-Host "WinRM service enabled and started"
    
    # Basic WinRM configuration
    Write-Host "Configuring basic WinRM settings..."
    winrm quickconfig -quiet
    
    # Enable certificate authentication
    Write-Host "Enabling certificate authentication..."
    winrm set winrm/config/service/auth '@{Certificate="true"}'
    
    # Allow unencrypted for HTTP (debugging only)
    winrm set winrm/config/service '@{AllowUnencrypted="true"}'
    
    # Import the AAP client certificate
    Write-Host "Installing AAP client certificate..."
    $certContent = @"
${certificate_content}
"@
    
    # Save certificate to file
    $tempCertFile = "C:\Windows\Temp\aap-client-cert.crt"
    $certContent | Out-File -FilePath $tempCertFile -Encoding ASCII
    
    # Import certificate to certificate stores
    Write-Host "Importing certificate to certificate stores..."
    $trustedCert = Import-Certificate -FilePath $tempCertFile -CertStoreLocation Cert:\LocalMachine\TrustedPeople
    $rootCert = Import-Certificate -FilePath $tempCertFile -CertStoreLocation Cert:\LocalMachine\Root
    
    Write-Host "Certificate imported. Thumbprint: $($trustedCert.Thumbprint)"
    
    # Create certificate mapping for Administrator
    Write-Host "Creating certificate mapping for Administrator..."
    $certSubject = $trustedCert.Subject
    $certIssuer = $trustedCert.Issuer
    
    # Simple certificate mapping
    $mapping = "@{Issuer=`"$certIssuer`";Subject=`"$certSubject`";UserName=`"Administrator`";Password=`"`";Enabled=`"true`"}"
    $mappingCmd = "winrm create winrm/config/service/certmapping `"$mapping`""
    
    Write-Host "Creating mapping with command: $mappingCmd"
    try {
        Invoke-Expression $mappingCmd
        Write-Host "Certificate mapping created successfully"
    } catch {
        Write-Host "Certificate mapping failed: $($_.Exception.Message)"
        Write-Host "Certificate authentication may not work, but password auth will be available"
    }
    
    # Configure firewall
    Write-Host "Configuring Windows Firewall..."
    netsh advfirewall firewall add rule name="WinRM HTTP" dir=in action=allow protocol=TCP localport=5985
    netsh advfirewall firewall add rule name="WinRM HTTPS" dir=in action=allow protocol=TCP localport=5986
    
    # Enable RDP for debugging
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -Value 0
    netsh advfirewall firewall add rule name="Remote Desktop" dir=in action=allow protocol=TCP localport=3389
    
    # Set Administrator password
    Write-Host "Setting Administrator password for fallback authentication..."
    $password = ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force
    Set-LocalUser -Name "Administrator" -Password $password
    Enable-LocalUser -Name "Administrator"
    
    # Clean up
    Remove-Item -Path $tempCertFile -Force -ErrorAction SilentlyContinue
    
    # Restart WinRM service
    Write-Host "Restarting WinRM service..."
    Restart-Service winrm -Force
    
    Write-Host "Configuration completed successfully!"
    
    # Display configuration
    Write-Host "=== WinRM Configuration ==="
    winrm get winrm/config/service/auth
    
    Write-Host "=== WinRM Listeners ==="
    winrm enumerate winrm/config/listener
    
    Write-Host "=== Certificate Mappings ==="
    winrm enumerate winrm/config/service/certmapping
    
} catch {
    Write-Error "Error in WinRM configuration: $($_.Exception.Message)"
    Write-Error $_.ScriptStackTrace
}

Stop-Transcript

Write-Host "Setup completed. Check log at: $logFile"
</powershell>
