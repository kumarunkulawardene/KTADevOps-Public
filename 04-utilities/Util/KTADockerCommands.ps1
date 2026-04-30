#Build TS image
docker build -t ktatransformation:v7.9 "C:\Kofax\KTADeployment"
docker build -t ktawebappssltal:v7.9 "C:\KTA" --build-arg ImageTag=4.8-20210713-windowsservercore-ltsc2019 --build-arg KTARole=WebAppS

#Run TS container
docker run -d -p 5000:80 ktatransformation:v7.9
docker run -d -p 5000:80 ktawebapp:v7.9.0.9-JUL2022

#Install TS
TransformationServerSetup.exe /quiet /log "C:\KTA\TSInstall.txt" TS_INSTALLLOCATION="C:\Program Files\Kofax\TotalAgility\Transformation Server" TS_SERVICE_ACCOUNT="KTA_Admin" TS_SERVICE_PASSWORD=<DB_PASSWORD>;Trusted_Connection=Yes;Database=TotalAgility;" TS_AUDIT_DB_CONNECTION_STRING="Server=<DB_SERVER>;Trusted_Connection=Yes;Database=TotalAgility;" TS_REPORTING_STAGING_DB_CONNECTION_STRING="Server=<DB_SERVER>;Trusted_Connection=Yes;Database=TotalAgility_Reporting_Staging;" TS_ARCHIVE_DB_CONNECTION_STRING="Server=<DB_SERVER>;Trusted_Connection=Yes;Database=TotalAgility;" TS_STARTSERVICE=TRUE


#Run WebApp container
docker run -d --hostname "ktawebapp" --name "ktawebapp" --env-file "C:\Docker\TotalAgility\dockersettings.env" -p 5000:80 imagename:tag
docker run -d --env-file "C:\KTA\DockerSettings_OnPremise_FullInstall.Env" -p 5000:80 ktawebappssltal:v7.9

docker run --env-file "C:\kta\DockerSettings_OnPremise_FullInstall.env" `
-e KTA_SSL_CERT_PASSWORD=<DB_PASSWORD>
-e KTA_SSL_CERT_PATH="C:\KTA\Certs\example-cert-w-chain.pfx" `
-e KTA_ROOT_SSL_CERT_PATH="C:\KTA\Certs\root.cer" `
-e KTA_CA_SSL_CERT_PATH="C:\KTA\Certs\example-cert-intermediate.cer" `
-v "C:\KTA\Certs:C:\KTA\Certs" `
-p 5000:443 -d ktawebappssltal:v7.9

#Connect to container interactively
docker exec -it containerid powershell

#Get event log
get-eventlog -Logname Application -newest 2 -source "TotalAgility" | format-table -auto -wrap

