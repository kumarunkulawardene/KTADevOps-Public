
** Upgrade Arefacts **
1. Customised DockerFile  
    - Select the approprate KTA base image (dependent on target deployment)
    - Copies the install media copied to c:\KTA-FixPack within the container)
2. InstallFixPack.ps1
    - Executes the silent install of the hotfix (custom script)

** Approach **
1. Modify the DockerFile to specify (uncomment) the appropriate KTA base image. 
2. Place the DockerFile into ..\DOCKER_BUILD
3. Place the install media for the fixpack into a local ..\DOCKER_BUILD\ContainerFiles\ folder
4. Place the InstallFixPack.ps1 into  ..\DOCKER_BUILD\ContainerFiles\PowershellScripts\ folder (only script present)
5. Update the ..\DOCKER_BUILD\ContainerFiles\TotalAgilityInstall\SilentInstallConfig.xml
    - Set IsDocker = true
    - Set CheckDatabaseCompatibility = false 
    - No other changes should be required - TBC
6. Run the Docker Build command (from DOCKER_BUILD path)  
    - docker build -t <imagename> .\
