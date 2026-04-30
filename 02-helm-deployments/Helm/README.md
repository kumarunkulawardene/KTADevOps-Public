# Helm Charts

This folder contains Helm charts and helper command scripts for Kubernetes deployment examples.

## Charts

| Chart | Purpose |
| --- | --- |
| `kta` | Basic TotalAgility deployment examples. |
| `kta-full` | Multi-role TotalAgility deployment examples. |
| `kta-ssl` | TotalAgility deployment examples with TLS-oriented settings. |
| `insight` | Insight deployment examples. |
| `insight-ssl` | Insight deployment examples with TLS-oriented settings. |
| `RPA` | RPA deployment examples. |
| `sample` | Generic Helm scaffold/reference chart. |

## Commands

Use `helm upgrade --install` after reviewing the target values file:

```powershell
helm upgrade --install kta .\kta-full -n kta -f .\kta-full\values_dev.yaml
helm upgrade --install insight .\insight -n kta -f .\insight\values_dev.yaml
```

## Review Before Deploying

- image repositories and tags
- namespace and environment prefix
- storage classes and persistent volume claims
- database connection references
- ingress hostnames, annotations, and TLS settings
- Key Vault / CSI driver identity settings
- resource sizing and autoscaling
