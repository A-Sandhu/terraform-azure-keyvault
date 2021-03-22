#Create RG for storing State Files
az group create --location westus2 --name rg-terraformstate

#Create Storage Account
az storage account create --name terrastatestg22032021 --resource-group rg-terraformstate --location westus2 --sku Standard_LRS

#Create Storage Container
az storage container create --name terraform --account-name terrastatestg22032021

#Enable versioning on Storage Account1
az storage account blob-service-properties update --account-name terrastatestg22032021 --enable-change-feed --enable-versioning true