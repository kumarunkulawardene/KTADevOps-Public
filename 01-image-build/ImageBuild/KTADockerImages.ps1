###############################################################################
# KTA Cloud Training Series - KTA Docker Image Build
# Build KTA Docker images
# 
# This script includes commands that can be used to build KTA Docker Images 
#
# Author: Kofax Professional Services Centre of Excellence (COE) 
##############################################################################
#
# Download KTA Istall media and extract to a local folder.
# Create a seperate folder e.g. C:\KTA to  oganise the files needed for Docker image creation
# Copy contents of <Installer Files>\Utilities\Docker into C:\KTA.
# Copy <Installer Files>\Utilities\Kofax.CEBPM.EncryptConfig.exe into C:\KTA\ContainerFiles\Utilities
# Copy <Installer Files>\Utilities\Pre-requisite Utility folder and contents into C:\KTA\ContainerFiles\Utilities
# Copy <Installer Files>\TotalAgilityInstall folder and contents into C:\KTA\ContainerFiles
#
# Then copy the relevant folder based on the KTA Image you are creating. I.e. if you are creating a Transformation only image then copy 
# <Installer Files>\TransformationServer folder into C:\KTA\ContainerFiles. The idea is to reduvc the build context and speed up the build process.
#
# Optional: create a separate folder to  craete the different SilentConfig files. Or you can update the SilientCofig file as required before each build.

# Build KTA Image
docker build -t ktatransformation:v7.9 "C:\KTA\"

# If you want to parameterise the image build you can update the Dockerfile to access certain parameters and build the image accordingly. 
# Sample dockerfile and updated ConfigureContainer.ps1 is provided in this folder (ImageBuild)
### docker build -t ktatransformation:v7.9 "C:\KTA\" --build-arg KTARole=Transformation --build-arg ImageTag=4.8-windowsservercore-ltsc2019
### docker build -t ktawebapp:v7.9.0.9-JUL2022 "C:\KTA\" --build-arg KTARole=WebApp --build-arg ImageTag=4.8-windowsservercore-ltsc2019

# To reduce the docker image size we can delete the temporary installer files created in the "C:\ProgramData\Program Cache" folder 
# after installation has completed. Do do this you can add the following lines to the end of the C:\KTA\ContainerFiles\PowershellScripts\ConfigureContainer.ps1.
###########################################################################################
filter timestamp {"$(Get-Date -Format G): $_"}
	Write-output "Delete Program Cache" | timestamp
	# Delete Program Cache

	Get-ChildItem -LiteralPath 'C:\ProgramData\Package Cache\'  -Recurse | 
	Select -ExpandProperty FullName | 
	sort length -Descending | 
		ForEach-Object {
			try {
					#  -ErrorAction Ignore is being used to suppress known issue in Docker on Windows Server 2016 with deletion
					Remove-Item -path $_ -force -ErrorAction Ignore;
				}
			catch { }
		}
	filter timestamp {"$(Get-Date -Format G): $_"}
	Write-output "Program Cache deletion completed" | timestamp	
############################################################################################

