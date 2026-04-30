#For SSL installation ensure the certificate thumbprint is added in InstallConfig.xml.

Build Insight Images
1. Change directory to C:\Insight\DockerFolder
2. Run the following command;
    docker-compose build 

    docker build -f .\InsightWeb.Dockerfile -t insightwebssl:v6.4 .


    docker run -v C:\Insight\InsightData:C:\Temp\InsightData insightwebssl:v6.4 