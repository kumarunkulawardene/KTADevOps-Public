﻿#Import SSL Cert

param (
	[string]$certPath = "C:\ContainerStore\cert.pfx",   
	[string]$rootCertPath = "",
	[string]$caCertPath = "",
	[string]$certPassword = <DB_PASSWORD>
	[string]$bindingHostHeader = ""
)

if (Test-Path $rootCertPath)
{
	$file = ( Get-ChildItem -Path  $rootCertPath )
	$file | Import-Certificate -CertStoreLocation cert:\LocalMachine\Root
}

if (Test-Path $caCertPath)
{
	$file = ( Get-ChildItem -Path  $caCertPath )
	$file | Import-Certificate -CertStoreLocation cert:\LocalMachine\CA
}

cd iis:
iisreset

if (Test-Path $certPath)
{    
    # Import certificate to container      
    $pfx = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2  
    $pfx.Import($certPath,$certPassword,"Exportable,MachineKeySet,PersistKeySet")   
    $store = New-Object System.Security.Cryptography.X509Certificates.X509Store("WebHosting","LocalMachine")   
    $store.Open("ReadWrite")  
    $store.Add($pfx)   
    $store.Close()   
    $certThumbprint = $pfx.Thumbprint  

    $thumbprints = Get-ChildItem -path cert:\LocalMachine\WebHosting;
         
    # assign cert to default web site
    $iisWebsiteName="Default Web Site"
      
    Import-Module WebAdministration 

    $binding1 = Get-WebBinding -Name $iisWebsiteName -Port 443 -Protocol "https";
        
    if($binding1 -eq $null)
    {            
        Write-Output (" Add new binding");
          
        New-WebBinding -Name "Default Web Site" -IP "*" -Port 443 -Protocol https;
        $binding1 = Get-WebBinding -Name $iisWebsiteName -Port 443 -Protocol "https";
    }
	
    Write-Host ("add cert");
    $binding1.AddSslCertificate($thumbprints[0].Thumbprint, "WebHosting");      

	if($bindingHostHeader -ne $null)
    {    
		Write-Host ("add host reader");
		Set-WebBinding -Name "Default Web Site" -BindingInformation "*:443:" -PropertyName "HostHeader" -Value $bindingHostHeader
	}
        
}
else
{
    Write-Output("Error: SSL Certificate not found @ '$certPath'");
}

cd iis:
iisreset
