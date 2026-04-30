#FROM sampleacr.azurecr.io/ktalicense:v7.9
FROM sampleacr.azurecr.io/ktawebapp:v7.9

COPY ContainerFiles C:\\KTA-FixPack

RUN powershell C:\KTA-FixPack\PowershellScripts\InstallFixPack.ps1

ENTRYPOINT powershell "C:\KTA\PowershellScripts\Startup.ps1"