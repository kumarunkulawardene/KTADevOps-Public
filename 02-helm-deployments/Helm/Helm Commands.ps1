#
#
#
#
#
#


# Install Helm
#   - Download Helm from Github
#   - Update the environment PATH to include the location of the Helm binary


# CREATE NEW HELM CHART

# Create a Helm Chart
# helm create [Chart]
# creates a new chart (folder scaffolding with sample files)
# you can then remove unnecessary files, replace and add yaml files as required. 
helm create kta

# DEPLOYMENT

#note: namespace must match namespace configured in values file passed to commands below
$namespace = "dev-kta"
$values_file = ".\kta\values_dev.yaml"

# Upload Cert for consumption in AGIC (can use a TLS secret) 
kubectl create secret tls kta-tls-secret --cert="C:\local\ExampleCustomer\pstal.crt" --key="C:\local\ExampleCustomer\pstal-decrypted.key"

# Upload Cert (.pfx) for consumption in KTA (use binary data in config map...KTA doesn't understand a tls secret)
kubectl create configmap kta-tls-config --from-file="c:\\local\\ExampleCustomer\\pstal.pfx" --namespace dev-kta

# Upload Cert (.pfx) for consumption in KTA (use binary data in config map...KTA doesn't understand a tls secret)
kubectl create configmap kta-tls-root-config --from-file="c:\\local\\ExampleCustomer\\psroot.cer" --namespace dev-kta

# Test the Templating (Displays the resulting YAML without executing against the cluster)
helm template kta --values ./kta/values_dev.yaml

#Install Root Cert for backend in AGIC (if backend certs are not using a trusted CA)
# See powershell
$resourceGroup = "MC_rgakskta_akskta2_uksouth"
$applicationGatewayName="ktaAppGateway"

# Add Root Certificate to AG
# Only required if backend uses 'untrusted' certificates i.e. not using well known CA Certificate.
az network application-gateway root-cert create `
    --gateway-name $applicationGatewayName  `
    --resource-group $resourceGroup `
    --name kta-backend-tls `
    --cert-file "c:\\local\\ExampleCustomer\\psroot.cer"


# Install the KTA Helm chart `
# helm install [Release Name] [CHART] [flags]	
# --values to specifiy the values
# namespace cannot be created like other 'Kind', so must be done via the commandline	
helm install kta kta --values $values_file --namespace $namespace --create-namespace

# Upgrade an existing deployment
# (Tracks verison history and supports rollback)
# Note - Update Chart verion (in Chart.yaml) for proper versioning
# Supports chart versioning independently of target software version changes 
helm upgrade kta kta --values $values_file

# see history of the the releases to the cluster
# helm history [RELEASE_NAME]
helm history kta2

helm rollback kta2 3
helm uninstall kta2

kubectl describe ingress

# List root certificates registered with AG
az network application-gateway root-cert list --gatway-name $applicationGatewayName --resource-group $resourceGroup 


# Powershell Testing - Ignore self-signed cert errors 
add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy

#Check server cert returned
Invoke-WebRequest https://localhost:443/totalagility/forms -Headers @{ host="kofaxpstal" }
$servicePoint = [System.Net.ServicePointManager]::FindServicePoint("https://localhost:443/totalagility/forms")
$servicePoint.Certificate.GetCertHashString()
$servicePoint.Certificate.GetExpirationDateString()
$servicePoint.Certificate.GetName()

