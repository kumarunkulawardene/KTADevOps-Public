# Utilities

This section contains helper commands and scripts that support image build, registry transfer, certificate handling, database setup, troubleshooting, and RPA examples.

## Contents

| Path | Purpose |
| --- | --- |
| `Util/CommonCommands.ps1` and `Util/CommonCommands.azcli` | General command references. |
| `Util/KTADockerCommands.ps1` | Docker commands useful for TotalAgility images and containers. |
| `Util/RPADockerCommands.ps1` | Docker commands useful for RPA examples. |
| `Util/TransferContainersImages.azcli` | Container image import/copy command examples. |
| `Util/CreateKTAAzureDatabases.azcli` | Azure SQL database creation examples. |
| `Util/CreateHttpsCert.ps1` and `Util/InstallSSLCertInGateway.azcli` | Certificate generation/import examples. |
| `Util/TroubleShootContainers.azcli` | AKS and container troubleshooting commands. |
| `RPA` | RPA-specific Docker Compose, AKS, and command examples. |

## Usage Guidance

- Treat these files as command references, not end-to-end automation.
- Run commands one block at a time and confirm the target subscription, resource group, namespace, and cluster context.
- Replace placeholders with values for the target environment before use.
- Use the target environment's standard certificate and database processes.

## Common Checks

```powershell
az account show
kubectl config current-context
kubectl get nodes -o wide
kubectl get pods -A
kubectl describe pod <POD_NAME> -n <NAMESPACE>
kubectl logs <POD_NAME> -n <NAMESPACE>
```
