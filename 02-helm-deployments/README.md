# Helm Deployments

This section contains Helm charts and Kubernetes deployment examples for TotalAgility, Insight, and RPA.

## Contents

| Path | Purpose |
| --- | --- |
| `Helm/kta` | Basic TotalAgility chart examples. |
| `Helm/kta-full` | Full TotalAgility deployment examples with multiple roles. |
| `Helm/kta-ssl` | TotalAgility examples with TLS-oriented configuration. |
| `Helm/insight` | Insight chart examples. |
| `Helm/insight-ssl` | Insight examples with TLS-oriented configuration. |
| `Helm/RPA` | RPA chart examples. |
| `Deployments` | Scenario-based `kubectl`/YAML deployment examples. |
| `Insight` | Standalone Insight Kubernetes YAML examples and sample license placeholder. |

## Typical Deployment Flow

1. Create or select the Kubernetes namespace.
2. Create or configure persistent storage.
3. Configure database connection settings and runtime settings.
4. Configure image repository, tags, image pull settings, and TLS settings in chart values.
5. Deploy charts using `helm install` or `helm upgrade --install`.
6. Validate pods, services, ingress, volumes, and application logs.

Example:

```powershell
helm upgrade --install kta .\Helm\kta-full -n kta -f .\Helm\kta-full\values_dev.yaml
helm upgrade --install insight .\Helm\insight -n kta -f .\Helm\insight\values_dev.yaml
```

## Values to Review

- `deployment.environmentPrefix`
- image repository and tag values
- database connection references
- storage account, share names, storage classes, and PVC names
- ingress hostnames and TLS resource names
- Key Vault, managed identity, and CSI Driver settings
- resource requests, limits, autoscaling, and node selectors

## Production Notes

- Use the platform's standard configuration-management approach.
- Use certificates issued for the target environment.
- Confirm ingress controller, WAF, DNS, and TLS behavior with the platform team.
- Confirm Windows node pool compatibility with the selected product version and base images.
