###############################################################################
# KTA Cloud Training Series - Insight Docker Image Build
# Build KTA Docker images
# 
# This script includes commands that can be used to build KTA Docker Images 
#
# Author: Kofax Professional Services Centre of Excellence (COE) 
##############################################################################
#
# 

# Build KTA Image
docker build -t ktatransformation:v7.9 "C:\KTA\"

# If you want to parameterise the image build you can update the Dockerfile to access certain parameters and build the image accordingly. 
# Sample dockerfile and updated ConfigureContainer.ps1 is provided in this folder (ImageBuild)
### docker build -t ktatransformation:v7.9 "C:\KTA\" --build-arg KTARole=Transformation --build-arg ImageTag=4.8-windowsservercore-ltsc2019

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

