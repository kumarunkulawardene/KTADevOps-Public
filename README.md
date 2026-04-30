# TotalAgility, Insight, and RPA Container Deployment Examples

This repository contains examples and helper scripts for building and deploying TotalAgility, Insight, and RPA container workloads.

The material is intended as a reference accelerator for adapting container image builds, Helm charts, AKS setup, and utility commands to a target environment.

## Repository Layout

| Folder | Purpose |
| --- | --- |
| `01-image-build` | Docker image build examples for TotalAgility roles and Insight, plus runtime configuration samples. |
| `02-helm-deployments` | Helm charts and Kubernetes deployment examples for TotalAgility, Insight, RPA, TLS, storage, ingress, and runtime configuration. |
| `03-azure-cluster` | Azure Kubernetes Service cluster creation and namespace examples. |
| `04-utilities` | Useful PowerShell, Azure CLI, Docker, certificate, database, and troubleshooting commands. |

## Typical Workflow

1. Prepare the AKS cluster and supporting Azure resources using `03-azure-cluster` and selected utilities from `04-utilities`.
2. Build or obtain Docker images for each required role using `01-image-build`.
3. Push images to the target container registry.
4. Review and update Helm values in `02-helm-deployments`.
5. Deploy runtime configuration, storage, ingress, and workloads through Helm or `kubectl`.
6. Validate pod startup, service endpoints, ingress health, storage mounts, and application logs.

## TotalAgility Image Roles

Most TotalAgility deployments use one image per role:

- `WebApp`
- `Transformation` / `TS`
- `Reporting`
- `License`
- `MC` / Message Connector

The samples show both single-role and combined-role patterns. Prefer role-specific images for predictable scaling, rollout, troubleshooting, and patching.

## Configuration Values

Example files use placeholder values for environment-specific settings such as Azure resources, container registries, database endpoints, ingress hosts, and runtime options. Replace placeholders with values for the target environment when adapting the examples.
