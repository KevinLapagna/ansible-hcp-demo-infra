<powershell>
# Windows WinRM Certificate Authentication Setup Script
# This script configures WinRM for certificate-based authentication

# Create log file
$logFile = "C:\Windows\Temp\winrm-setup.log"
Start-Transcript -Path $logFile -Append

Write-Host "Starting WinRM certificate authentication configuration..."

try {
    # Enable WinRM service
    Write-Host "Enabling WinRM service..."
    Enable-PSRemoting -Force
    
    # Configure WinRM settings
    Write-Host "Configuring WinRM settings..."
    winrm set winrm/config '@{MaxTimeoutms="1800000"}'
    winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="2048"}'
    winrm set winrm/config/service '@{AllowUnencrypted="false"}'
    winrm set winrm/config/service/auth '@{Basic="false"}'
    winrm set winrm/config/service/auth '@{Kerberos="true"}'
    winrm set winrm/config/service/auth '@{Negotiate="true"}'
    winrm set winrm/config/service/auth '@{Certificate="true"}'
    winrm set winrm/config/service/auth '@{CredSSP="false"}'
    
    # Configure HTTPS listener
    Write-Host "Configuring HTTPS listener..."
    
    # Remove existing HTTPS listener if it exists
    try {
        winrm delete winrm/config/Listener?Address=*+Transport=HTTPS
    } catch {
        Write-Host "No existing HTTPS listener found"
    }
    
    # Create self-signed certificate for WinRM HTTPS
    Write-Host "Creating self-signed certificate for WinRM HTTPS..."
    $hostname = [System.Net.Dns]::GetHostName()
    $cert = New-SelfSignedCertificate -DnsName $hostname -CertStoreLocation Cert:\LocalMachine\My -KeyUsage DigitalSignature,KeyEncipherment -KeyAlgorithm RSA -KeyLength 2048
    
    # Create HTTPS listener with the certificate
    Write-Host "Creating HTTPS listener..."
    $thumbprint = $cert.Thumbprint
    winrm create winrm/config/Listener?Address=*+Transport=HTTPS "@{Hostname=`"$hostname`";CertificateThumbprint=`"$thumbprint`"}"
    
    # Import the AAP client certificate for authentication
    Write-Host "Installing AAP client certificate..."
    $certContent = @"
${certificate_content}
"@
    
    # Save certificate to temporary file
    $tempCertFile = "C:\Windows\Temp\aap-client-cert.crt"
    $certContent | Out-File -FilePath $tempCertFile -Encoding ASCII
    
    # Import certificate to Trusted Root and TrustedPeople stores
    Write-Host "Importing certificate to certificate stores..."
    Import-Certificate -FilePath $tempCertFile -CertStoreLocation Cert:\LocalMachine\Root
    Import-Certificate -FilePath $tempCertFile -CertStoreLocation Cert:\LocalMachine\TrustedPeople
    
    # Get the certificate from the store to get its thumbprint
    $importedCert = Get-ChildItem -Path Cert:\LocalMachine\TrustedPeople | Where-Object {$_.Subject -like "*Administrator*"} | Select-Object -First 1
    
    if ($importedCert) {
        Write-Host "Certificate imported successfully. Thumbprint: $($importedCert.Thumbprint)"
        
        # Map certificate to Administrator user
        Write-Host "Mapping certificate to Administrator user..."
        $adminSid = (New-Object System.Security.Principal.SecurityIdentifier("S-1-5-21-*-500")).Translate([System.Security.Principal.NTAccount]).Value
        if (-not $adminSid) {
            # Fallback: get Administrator SID
            $adminSid = ([System.Security.Principal.SecurityIdentifier]::new([System.Security.Principal.WellKnownSidType]::AccountAdministratorSid, $null)).Translate([System.Security.Principal.NTAccount]).Value
        }
        
        # Create certificate mapping
        winrm create winrm/config/service/certmapping "@{Subject=`"Administrator`";URI=`"*`";Issuer=`"$($importedCert.Thumbprint)`";UserName=`"Administrator`";Password=`"`"}"
    } else {
        Write-Host "Warning: Could not find imported certificate"
    }
    
    # Configure firewall rules
    Write-Host "Configuring Windows Firewall..."
    
    # Allow WinRM HTTPS
    New-NetFirewallRule -DisplayName "WinRM HTTPS" -Direction Inbound -Protocol TCP -LocalPort 5986 -Action Allow -ErrorAction SilentlyContinue
    
    # Allow WinRM HTTP (for debugging)
    New-NetFirewallRule -DisplayName "WinRM HTTP" -Direction Inbound -Protocol TCP -LocalPort 5985 -Action Allow -ErrorAction SilentlyContinue
    
    # Allow RDP (for debugging)
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
    
    # Set Administrator password (for fallback authentication)
    Write-Host "Setting Administrator password..."
    $password = ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force
    Set-LocalUser -Name "Administrator" -Password $password
    Enable-LocalUser -Name "Administrator"
    
    # Clean up temporary certificate file
    Remove-Item -Path $tempCertFile -Force -ErrorAction SilentlyContinue
    
    # Restart WinRM service
    Write-Host "Restarting WinRM service..."
    Restart-Service winrm
    
    # Test WinRM configuration
    Write-Host "Testing WinRM configuration..."
    winrm enumerate winrm/config/listener
    
    Write-Host "WinRM certificate authentication configuration completed successfully!"
    
} catch {
    Write-Error "Error configuring WinRM: $($_.Exception.Message)"
    Write-Error $_.ScriptStackTrace
}

Stop-Transcript

# Final verification
Write-Host "WinRM Listeners:"
winrm enumerate winrm/config/listener

Write-Host "Certificate Mappings:"
winrm enumerate winrm/config/service/certmapping

Write-Host "Setup completed. Check log at: $logFile"
</powershell>
