# ImageBuild Working Files

This folder contains the primary image-build examples and scripts.

## Key Files

| File or folder | Purpose |
| --- | --- |
| `Dockerfile` | Example Dockerfile for parameterized TotalAgility image builds. |
| `ConfigureContainer.ps1` | Example container configuration script. |
| `KTADockerImages.ps1` | TotalAgility image build command examples. |
| `InsightDockerImages.ps1` | Insight image build command examples. |
| `DeleteProgramCache.ps1` | Optional cleanup script to reduce Windows image size. |
| `KTA` | Additional TotalAgility build context variations. |
| `Insight` | Additional Insight build context variations. |

## Role Build Arguments

Common TotalAgility role values include:

- `WebApp`
- `TS` or `Transformation`
- `Reporting`
- `License`
- `MC`

Confirm the exact role names expected by the Dockerfile and scripts before building.

## Build Example

```powershell
docker build -t ktawebapp:v7.9 "C:\KTA" --build-arg KTARole=WebApp --build-arg ImageTag=4.8-windowsservercore-ltsc2019
```
