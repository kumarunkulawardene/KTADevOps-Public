# Azure Cluster

This section contains Azure Kubernetes Service helper scripts and namespace examples.

## Contents

| Path | Purpose |
| --- | --- |
| `Cluster/create_aks_cluster_generic.azcli` | Generic AKS creation command examples. |
| `Cluster/namespace-kta.yaml` | Example namespace manifest. |
| Other `Cluster/*.azcli` files | Alternate cluster creation approaches retained as references. |

## Typical AKS Preparation Flow

1. Confirm Azure subscription, region, networking, identity, and governance requirements.
2. Create or select the resource group.
3. Create the AKS cluster with the required Linux and Windows node pools.
4. Enable required add-ons or integrations such as monitoring, ingress, and managed identity.
5. Attach or authorize access to the container registry.
6. Configure storage classes, Key Vault access, ingress, and namespaces.

Example:

```powershell
az login
az account set --subscription <SUBSCRIPTION_ID>
az group create --name <RESOURCE_GROUP> --location <LOCATION>
az aks get-credentials --resource-group <RESOURCE_GROUP> --name <AKS_CLUSTER_NAME>
kubectl apply -f .\Cluster\namespace-kta.yaml
```

## Cluster Notes

- Review network design before running any cluster creation command.
- Align Kubernetes version and Windows node image support with the product image base.
- Replace placeholder values before use.
- Validate that cluster identity has the required registry, storage, Key Vault, and ingress permissions.
