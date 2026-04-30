

# Install Helm
#   - Download Helm from Github
#   - Update the environment PATH to include the location of the Helm binary

#note: namespace must match namespace configured in values file passed to commands below
$namespace = "kta"
$values_file = ".\kta-full\values_test.yaml"
az account set --subscription 0c3c4453-XXXX-XXXX-XXXX-XXXXXXXXXXX
az aks get-credentials --resource-group $resourceGroup --name $clusterName
# Test the Templating (Displays the resulting YAML without executing against the cluster)
helm template kta-full --values ./kta-full/values_dev.yaml
helm template rpa --values .\rpa\values_dev.yaml 


# Install the KTA Helm chart `
# helm install [NAME] [CHART] [flags]	
# --values to specifiy the values
# namespace cannot be created like other 'Kind', so must be done via the commandline	
helm install kta-full kta-full --values .\kta-full\values_dev.yaml --namespace kta 
helm install insight insight --values .\insight\values_dev.yaml --namespace kta
helm install rpa rpa --values .\rpa\values_dev.yaml --namespace kta

# Upgrade an existing deployment
helm upgrade kta-full kta-full --values .\kta-full\values_dev.yaml --namespace kta 
helm upgrade insight insight --values .\insight\values_dev.yaml --namespace kta 
helm upgrade rpa rpa --values .\rpa\values_dev.yaml --namespace kta 


#Uninstall
helm uninstall kta-full kta-full -n kta 
helm uninstall insight insight -n kta 
helm uninstall rpa rpa -n kta 

# see history of the the releases to the cluster
# helm history [RELEASE_NAME]
helm history kta
