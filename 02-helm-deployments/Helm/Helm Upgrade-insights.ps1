
# Install Helm
#   - Download Helm from Github
#   - Update the environment PATH to include the location of the Helm binary

#note: namespace must match namespace configured in values file passed to commands below
$namespace = "devkta"
$insights_values_file = "./insight-ExampleCustomer/values_dev.yaml"

az account set --subscription <GUID>
az aks get-credentials --resource-group akscluster-v2-nonprod-001 --name shared-aks-v2

# Test the Templating (Displays the resulting YAML without executing against the cluster)
#helm template kta-ExampleCustomer --values ./kta-ExampleCustomer/values_dev.yaml

# Install the KTA Helm chart `
# helm install [NAME] [CHART] [flags]	
# --values to specifiy the values
# namespace cannot be created like other 'Kind', so must be done via the commandline	

helm upgrade insight-ExampleCustomer insight-ExampleCustomer --values $insights_values_file --namespace $namespace


# see history of the the releases to the cluster
# helm history [RELEASE_NAME]
helm history $namespace