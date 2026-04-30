############################################################################
# ** Build Utility **
# This is a customisation of the KTA 7.9 DockerFile which paramaterises
#   - ImageTag
#   - KTARole   
#
# Created By	:	Kumarun Kulawardene
############################################################################

ARG ImageTag

FROM mcr.microsoft.com/dotnet/framework/aspnet:$ImageTag

ARG KTARole

#RUN Write-Host KTARole: $env:KTARole

COPY ContainerFiles ContainerFiles_$KTARole C:\\KTA\\

#RUN powershell C:\KTA\CopySilentConfig.ps1 -KTARole $env:KTARole -InstallerPath "C:\KTA"

RUN powershell C:\KTA\PowershellScripts\ConfigureContainer.ps1 -KTARole $env:KTARole

EXPOSE 80

EXPOSE 443

ENTRYPOINT powershell "C:\KTA\PowershellScripts\Startup.ps1"