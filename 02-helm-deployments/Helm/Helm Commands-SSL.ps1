

# Install Helm
#   - Download Helm from Github
#   - Update the environment PATH to include the location of the Helm binary

#note: namespace must match namespace configured in values file passed to commands below
$namespace = "kta"
$values_file = ".\values_dev.yaml"
az account set --subscription <GUID>
az aks get-credentials --resource-group akscluster-v2-nonprod-001 --name shared-aks-v2
# Test the Templating (Displays the resulting YAML without executing against the cluster)
helm template kta-ssl --values ./kta-ssl/values_dev.yaml

# Install the KTA Helm chart `
# helm install [NAME] [CHART] [flags]	
# --values to specifiy the values
# namespace cannot be created like other 'Kind', so must be done via the commandline	
helm install kta-ssl kta-ssl --values ./kta-ssl/values_dev.yaml --namespace kta 
helm install insight-ssl insight-ssl --values .\insight-ssl\values_dev.yaml --namespace kta

# Upgrade an existing deployment
helm upgrade kta-ssl kta-ssl --values ./kta-ssl/values_dev.yaml --namespace kta
helm upgrade insight-ssl insight-ssl --values .\insight-ssl\values_dev.yaml --namespace kta 


#Uninstall
helm uninstall kta-ssl kta-ssl -n kta 
helm uninstall insight-ssl insight-ssl -n kta

# see history of the the releases to the cluster
# helm history [RELEASE_NAME]
helm history kta
