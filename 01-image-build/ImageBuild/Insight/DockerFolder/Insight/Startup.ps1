﻿foreach($ev in [System.Environment]::GetEnvironmentVariables('process').Keys)
{
    [System.Environment]::SetEnvironmentVariable($ev,[System.Environment]::GetEnvironmentVariable($ev,'process'), 'machine');
}

# get current script path
$pos = $MyInvocation.MyCommand.Path.IndexOf($MyInvocation.MyCommand.Name);

#Remove current script name
$currentPath = $MyInvocation.MyCommand.Path.SubString(0,$pos);


# Import Certificate
$certPath =[Environment]::getEnvironmentVariable('SSL_CERT_PATH');
$certPasswordPath =[Environment]::getEnvironmentVariable('SSL_CERT_PASSWORD_PATH');
$certPassword =<DB_PASSWORD>;
$bindingHostHeader = [Environment]::getEnvironmentVariable('WEB_BINDING_HOST_HEADER');
$rootCertPath = [Environment]::getEnvironmentVariable('ROOT_SSL_CERT_PATH');
$caCertPath = [Environment]::getEnvironmentVariable('CA_SSL_CERT_PATH');

if($certPasswordPath -ne $null)
{
    #check password file path
    if(Test-Path $certPasswordPath)
    {    
      $certPassword = <DB_PASSWORD>;
    }
}

if($certPath -ne $null -and $certPassword -ne $null)
{
    Write-Output("Importing certificate $certPath");        
    Invoke-Expression "$currentPath\ImportSSLCert.ps1 -certPath '$certPath' -certPassword '$certPassword' -bindingHostHeader '$bindingHostHeader' -rootCertPath '$rootCertPath' -caCertPath '$caCertPath'";

    #Reset envoirnment varible.
    [Environment]::SetEnvironmentVariable('SSL_CERT_PASSWORD_PATH', $null, 'Process');
    [Environment]::SetEnvironmentVariable('SSL_CERT_PATH', $null, 'Process');
    [Environment]::SetEnvironmentVariable('SSL_CERT_PASSWORD', $null, 'Process');

    [Environment]::SetEnvironmentVariable('SSL_CERT_PASSWORD_PATH', $null, 'Machine');
    [Environment]::SetEnvironmentVariable('SSL_CERT_PATH', $null, 'Machine');
    [Environment]::SetEnvironmentVariable('SSL_CERT_PASSWORD', $null, 'Machine');

    [Environment]::SetEnvironmentVariable('SSL_CERT_PASSWORD_PATH', $null, 'User');
    [Environment]::SetEnvironmentVariable('SSL_CERT_PATH', $null, 'User');
    [Environment]::SetEnvironmentVariable('SSL_CERT_PASSWORD', $null, 'User');   
}


$sleep = 500
while ($true)
{
    Start-Sleep $sleep
} 