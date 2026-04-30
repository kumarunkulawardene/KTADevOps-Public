FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019

RUN powershell -NoProfile -Command \
    Dism /online /enable-feature /featurename:WCF-HTTP-Activation45 /all;

RUN NET USER Insight_Admin /add
RUN NET LOCALGROUP Administrators /add Insight_Admin
RUN NET ACCOUNTS /maxpwage:unlimited

SHELL ["powershell", "-Command"]

RUN Write-Host 'Downloading Microsoft Redistributive Packages' ; \  
$RedistFile = $env:Temp + '\vc_redist.x64.exe' ; \
(New-Object Net.WebClient).DownloadFile('https://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x64.exe', $RedistFile) ; \
Write-Host 'Installing Microsoft Redistributive Packages' ; \
Start-Process $RedistFile -ArgumentList '/quiet', '/norestart' -NoNewWindow -Wait

RUN Write-Host 'Microsoft Access Database Engine 2016 Redistributable' ; \  
$MdacFile = $env:Temp + '\AccessDatabaseEngine_X64.exe' ; \
(New-Object Net.WebClient).DownloadFile('https://download.microsoft.com/download/3/5/C/35C84C36-661A-44E6-9324-8786B8DBE231/accessdatabaseengine_X64.exe', $MdacFile) ; \
Write-Host 'Microsoft Access Database Engine 2016 Redistributable' ; \
Start-Process $MdacFile -ArgumentList '/quiet', '/norestart' -NoNewWindow -Wait

COPY Insight c:\\Insight

RUN c:\\Insight\\install_fonts.ps1	

#Update Registry for ExampleCustomer (added 15/08/2022)
RUN c:\\Insight\\ConfigureContainer.ps1	

USER Insight_Admin

RUN Start-Process msiexec.exe -ArgumentList '/i', 'C:\Insight\KofaxInsightSetup_6.4.0.0.0.626_x64.msi', '/qn', 'INSTALLATION_TYPE=CUSTOM', 'INSTALLATION_TYPE_W=1', 'INSTALLATION_TYPE_I=1', 'INSTALLATION_TYPE_S=0' -NoNewWindow -Wait

#uncomment the line below to install Fix Pack
#RUN Start-Process msiexec.exe -ArgumentList '/update', 'C:\Insight\KofaxInsightSetup_FixPack.msp', '/qn' -NoNewWindow -Wait

RUN Start-Process -FilePath 'C:\Program Files\Kofax\Insight 6.4.0\InstallManager\Altosoft.Insight.InstallManager.exe' -ArgumentList '/i', '/a', '/f', 'c:\Insight\InstallConfig.xml' -Wait


RUN Import-Module WebAdministration; \ 
    Set-ItemProperty 'IIS:\AppPools\DefaultAppPool' -Name 'processModel.loadUserProfile' -Value 'True'; \
    Set-ItemProperty 'IIS:\AppPools\DefaultAppPool' -Name 'processModel.setProfileEnvironment' -Value 'True';\
	Set-ItemProperty 'IIS:\AppPools\DefaultAppPool' -Name 'processModel' -Value @{ userName='Insight_Admin'; identitytype=3 }
	
RUN & c:\windows\system32\inetsrv\appcmd.exe \ 
      unlock config \
      /section:system.webServer/handlers

RUN [System.Environment]::SetEnvironmentVariable('ChartSnapshot_Insight.Pdf.AdditionalArguments', '--no-sandbox', 'machine')

#COPY License.xml c:\\ProgramData\\Altosoft.Insight.Licenses

EXPOSE 80

EXPOSE 443

ENTRYPOINT powershell -File 'C:\\Insight\\Startup.ps1'