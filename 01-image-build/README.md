# Image Build

This section contains examples for building Docker images for TotalAgility and Insight.

## Contents

| Path | Purpose |
| --- | --- |
| `ImageBuild` | Main Dockerfile, PowerShell snippets, and build command examples. |
| `ImageBuild/KTA` | Additional TotalAgility image-build variations, including Docker folder structure and role-specific install configuration examples. |
| `ImageBuild/Insight` | Insight image-build examples for Docker, Kubernetes, and Docker Compose style layouts. |
| `ImageUpgrade` | Examples for applying a fix pack or upgrade during image build. |
| `MasterRunTimeConfigs` | Runtime `.Env` and Kubernetes configuration examples for different TotalAgility roles. |

## TotalAgility Role Images

Build one image per role when possible:

- WebApp
- Transformation Server
- Reporting
- License
- Message Connector / MC

Role-specific images make it easier to scale and patch components independently.

## General Build Flow

1. Download and extract the TotalAgility or Insight installation media.
2. Create a clean Docker build context.
3. Copy only the role-specific installer folders required for the target image.
4. Update silent install configuration files so services and database installation are appropriate for container use.
5. Build the image with the required role and base image arguments.
6. Tag and push the image to the target container registry.

Example:

```powershell
docker build -t ktawebapp:v7.9 "C:\KTA" --build-arg KTARole=WebApp --build-arg ImageTag=4.8-windowsservercore-ltsc2019
docker build -t ktatransformation:v7.9 "C:\KTA" --build-arg KTARole=TS --build-arg ImageTag=4.8-windowsservercore-ltsc2019
docker build -t ktareporting:v7.9 "C:\KTA" --build-arg KTARole=Reporting --build-arg ImageTag=4.8-windowsservercore-ltsc2019
docker build -t ktalicense:v7.9 "C:\KTA" --build-arg KTARole=License --build-arg ImageTag=4.8-windowsservercore-ltsc2019
docker build -t ktamc:v7.9 "C:\KTA" --build-arg KTARole=MC --build-arg ImageTag=4.8-windowsservercore-ltsc2019
```

## Build Notes

- Confirm the base Windows image tag matches the target Kubernetes Windows node pool.
- Replace all placeholder values before use.
- Obtain any required product media through approved distribution channels.
