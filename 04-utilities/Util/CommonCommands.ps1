#Get local users
Get-LocalUser | Select *

#Copy files
copy-item C:\KTA\SilentInstallConfig.xml C:\KTA\TotalAgilityInstall\

#Change AZ Context
Connect-AzAccount

#Inspect docker images and get OS version
docker inspect <imageid>

# Get size of the folder in GB or MB
$folderInfo = Get-ChildItem -Recurse | Measure-Object -Property Length -Sum
$allfilesCount = $folderInfo.Count
$folderSize = $folderInfo.Sum
$folderSizeMB = [System.Math]::Round((($folderSize)/1MB),2)
$folderSizeGB = [System.Math]::Round((($folderSize)/1GB),2)
Write-Host "Folder Size(MB): "$folderSizeMB  "Total Files: "$filesCount -ForegroundColor Green
Write-Host "Folder Size(GB): "$folderSizeGB -ForegroundColor Green

# Copy files from azure fileshare
### Easiest way is in Azure portal go to "File Shares", select the file share and select "Connect".. copy the command and paste it in 
### the powshell windows and execute. This will map the Azure File Share as a network drive to the VM. Then you can copy the files you 
### need using "Copy-Item" command

### If you have GUI based windows you can install AzCopy and run the following command to download the files to local storage
.\AzCopy /Source:https://kofaxcoestorage.file.core.windows.net/kofaxcoesfileshare/Test/ /Dest:C:\KTA /SourceKey:key

[Environment]::GetEnvironmentVariables()


# Get IIS bindings and certs

Import-Module -Name WebAdministration

Get-ChildItem -Path IIS:SSLBindings | ForEach-Object -Process `
{
    if ($_.Sites)
    {
        $certificate = Get-ChildItem -Path CERT:LocalMachine/WebHosting |
            Where-Object -Property Thumbprint -EQ -Value $_.Thumbprint

        [PsCustomObject]@{
            Sites                        = $_.Sites.Value
            CertificateFriendlyName      = $certificate.FriendlyName
            CertificateDnsNameList       = $certificate.DnsNameList
            CertificateNotAfter          = $certificate.NotAfter
            CertificateIssuer            = $certificate.Issuer
            CertificateIssuer            = $certificate.Thumbprint
        }
    }
}

#####

## get certificates
Get-ChildItem Cert:\LocalMachine\WebHosting\* | ft -AutoSize
###