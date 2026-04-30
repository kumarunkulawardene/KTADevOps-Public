#SQL Image creation
docker build -f .\docker-win\sqlserver\Dockerfile -t sqlserverexpress:11.0.0.1 .

#MC Image creation
docker build -f .\docker-win\managementconsole\Dockerfile -t managementconsolewin2016:11.0.0.1 .

#RoboServer Image creation
docker build -f .\docker-win\roboserver\Dockerfile -t roboserverlocalsql:11.0.0.1 .

#Robot File System Image Creation
docker build -f .\docker-win\robotfilesystem\Dockerfile -t robotfilesystem:11.0.0.1 .

#Synchronnizer Image creation
docker build -f .\docker-win\synchronizer\Dockerfile -t synchronizer:11.0.0.1 .

#Kapplets Image creation
docker build -f .\docker-win\kapplets\Dockerfile -t kapplets:11.0.0.1 .




#SQL Server Container Creation
docker container run -d -p 1433:1433 --env ACCEPT_EULA=Y  --env SA_PASSWORD=<DB_PASSWORD>


#MC Contianer creation
docker container run -d -p 8080:8080 --env CONTEXT_RESOURCE_VALIDATIONQUERY='SELECT 1' --env CONTEXT_RESOURCE_USERNAME=rpasqladmin --env CONTEXT_RESOURCE_PASSWORD=<DB_PASSWORD>;database=scheduler;user=sa;password=<DB_PASSWORD>;' --env CONTEXT_CHECK_DATABASE_TIMEOUT=600 managementconsolesql2019:11.0.0.1


# RoboServer container creation
docker container run -d --env ROBOSERVER_ENABLE_MC_REGISTRATION=true --env ROBOSERVER_MC_URL='http://172.30.133.5:8080/' --env ROBOSERVER_MC_CLUSTER=Production --env ROBOSERVER_MC_USERNAME=admin --env ROBOSERVER_MC_PASSWORD=<DB_PASSWORD>


# Robot File System container creation
docker container run -d -p 81:8080  -v 'c:\rpacontainerdata\rfs:c:/data' --env RFS_MC_URL='http://172.30.133.5:8080/' --env RFS_MC_USERNAME=admin --env RFS_MC_PASSWORD=<DB_PASSWORD>


#Synchornizer
docker container run -d --env COMPOSE_CONVERT_WINDOWS_PATHS --env SYNCHRONIZER_MC_URL='http://172.30.133.5:8080/' --env SYNCHRONIZER_USERNAME=sync --env SYNCHRONIZER_PASSWORD=<DB_PASSWORD>


#Kapplets
docker container run -d  -p 8081:8080 -p 5005 --env SPRING_DATASOURCE_URL='jdbc:sqlserver://172.30.133.5:1433;database=kapplets;user=rpasqladmin;password=<DB_PASSWORD>;' --env SPRING_DATASOURCE_DRIVERCLASSNAME=com.microsoft.sqlserver.jdbc.SQLServerDriver --env SPRING_DATASOURCE_USERNAME=rpasqladmin --env SPRING_DATASOURCE_PASSWORD=<DB_PASSWORD>






#mount volume to contianer
docker run -v C:/RPAContainerFilles:C:/kapow/tomcat managementconsole:11.0.0.1


docker run -v C:\rpacontainerdata\synchornizer:C:\kapow synchronizer:11.0.0.1 


docker run -v c:\rpacontainerdata\rfs:c:/kapow/data roboserver:11.0.0.1 

#remove container
docker rm container  f1386a0b6dd2

#Untag an image
docker rmi sampleacr.azurecr.io/ktawebapp77:v1

#delete image
docker rmi <image id>

#get list of stopped containers
docker ps -ls

#purge unused containers
docker container prune

# conntect to container using powershell e.g
docker exec -it <conteint-id> powershell


#Tag image
Docker tag 3ece8212c000 sampleacr.azurecr.io/managementconsole:v1


#Save synchronizer settings
.\Synchronizer.exe -c --mc-url 'http://172.30.133.5:8080/' --username sync --password XXXXXXXXX --interval 1 --no-host-key true --private-key 'c:/kapow/gitkeys/id_rsa' -s

#run the synchronizer

#View/read content of files in powershell
Get-Content -Path 'C:\Users\ContainerAdministrator\AppData\Local\Kofax RPA\11.0.0.1_241\Logs\2020-08-13 12_32_28 Synchronizer.log'

#Get windows OS name
(Get-WmiObject -class Win32_OperatingSystem).Caption