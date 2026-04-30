# Create AKS Cluster

az aks create --resource-group kofax-ps-coe-au-kofaxrpa-rg --name kofax-coe-rpa-aks-cluster --node-count 2 --generate-ssh-keys --windows-admin-password <WINDOWS_ADMIN_PASSWORD> --windows-admin-username kofaxrpaadmin --vm-set-type VirtualMachineScaleSets --network-plugin azure

admin password = <DB_PASSWORD>


#Add a windows server node pool
az aks nodepool add --resource-group kofax-ps-coe-au-kofaxrpa-rg --cluster-name kofax-coe-rpa-aks-cluster --os-type Windows --name npwin --node-count 1


#Conect to cluster
az aks get-credentials --resource-group kofax-ps-coe-au-kofaxrpa-rg --name kofax-coe-rpa-aks-cluster

# get cluster nodes
kubectl get nodes

#Attach ACR
az aks update -n kofax-coe-rpa-aks-cluster -g kofax-ps-coe-au-kofaxrpa-rg --attach-acr kofaxpscoe

#Run the deployment
kubectl apply -f aks-rpa-mc-rs.yaml

#monitor the deployment
kubectl get pods

#Test application
kubectl get service mc --watch