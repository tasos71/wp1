#!/bin/bash

# Variables for the NSG deployment
RESOURCE_GROUP_EU="tech_task-WP01--RG_EU_West"
RESOURCE_GROUP_US="tech_task-WP01--RG_US_West"
LOCATION_EU="westeurope"
LOCATION_US="westus"
NSG_NAME_FILESERVER="tech_task-WP01--FileServerNSG"
NSG_NAME_ADMIN="tech_task-WP01--AdminNSG"
NSG_NAME_US="tech_task-WP01--USNSG"
SUBNET_NAME_EU_1="tech_task-WP01--Subnet_EU_West1"  # For file server and web service
SUBNET_NAME_EU_2="tech_task-WP01--Subnet_EU_West2"  # For admin access
SUBNET_NAME_US_1="tech_task-WP01--Subnet_US_West01" # For US VNET
SUBNET_NAME_US_2="tech_task-WP01--Subnet_US_West02" # For US VNET
VNET_NAME_EU="tech_task-WP01--VNet_EU_West"
VNET_NAME_US="tech_task-WP01--VNet_US_West"

# US Subnet IP ranges (from the US VNet)
US_SUBNET_1="10.2.1.0/24"  # First US subnet IP range
US_SUBNET_2="10.2.2.0/24"  # Second US subnet IP range

# Admin IP range for trusted access (Replace with actual trusted IP range)
ADMIN_IP_RANGE="10.3.2.0/24"  # Replace with your actual trusted IP range

# ---------------------------------
# NSG for EU Region (File Server and Web Service)
# ---------------------------------

echo "Creating Network Security Group for the file server and web service in EU..."
az network nsg create \
  --resource-group "$RESOURCE_GROUP_EU" \
  --name "$NSG_NAME_FILESERVER" \
  --location "$LOCATION_EU"

# Allow inbound SMB (Port 445) from US subnets to the file server
az network nsg rule create \
  --resource-group "$RESOURCE_GROUP_EU" \
  --nsg-name "$NSG_NAME_FILESERVER" \
  --name "AllowSMBInboundFromUS" \
  --priority 100 \
  --direction Inbound \
  --access Allow \
  --protocol Tcp \
  --destination-port-range 445 \
  --source-address-prefix "$US_SUBNET_1" \
  --destination-address-prefix "*" \
  --description "Allow SMB inbound from US Subnet 1"

az network nsg rule create \
  --resource-group "$RESOURCE_GROUP_EU" \
  --nsg-name "$NSG_NAME_FILESERVER" \
  --name "AllowSMBInboundFromUSSubnet2" \
  --priority 101 \
  --direction Inbound \
  --access Allow \
  --protocol Tcp \
  --destination-port-range 445 \
  --source-address-prefix "$US_SUBNET_2" \
  --destination-address-prefix "*" \
  --description "Allow SMB inbound from US Subnet 2"

# Allow inbound HTTP (Port 80) and HTTPS (Port 443) for the web service
az network nsg rule create \
  --resource-group "$RESOURCE_GROUP_EU" \
  --nsg-name "$NSG_NAME_FILESERVER" \
  --name "AllowHTTPHTTPSInbound" \
  --priority 200 \
  --direction Inbound \
  --access Allow \
  --protocol Tcp \
  --destination-port-range 80 443 \
  --source-address-prefix "*" \
  --destination-address-prefix "*" \
  --description "Allow HTTP and HTTPS traffic for web service"

# Deny all other inbound traffic to the file server and web service subnet
az network nsg rule create \
  --resource-group "$RESOURCE_GROUP_EU" \
  --nsg-name "$NSG_NAME_FILESERVER" \
  --name "DenyAllOtherInboundFileServer" \
  --priority 4096 \
  --direction Inbound \
  --access Deny \
  --protocol "*" \
  --destination-port-range "*" \
  --source-address-prefix "*" \
  --destination-address-prefix "*" \
  --description "Deny all other inbound traffic to the file server and web service subnet"

# Apply NSG to the file server and web service subnet
echo "Associating NSG with file server and web service subnet in EU..."
az network vnet subnet update \
  --resource-group "$RESOURCE_GROUP_EU" \
  --vnet-name "$VNET_NAME_EU" \
  --name "$SUBNET_NAME_EU_1" \
  --network-security-group "$NSG_NAME_FILESERVER"

# ---------------------------------
# NSG for Admin Access in EU Region
# ---------------------------------

echo "Creating Network Security Group for admin access in EU..."
az network nsg create \
  --resource-group "$RESOURCE_GROUP_EU" \
  --name "$NSG_NAME_ADMIN" \
  --location "$LOCATION_EU"

# Allow RDP (Port 3389) access for admins
az network nsg rule create \
  --resource-group "$RESOURCE_GROUP_EU" \
  --nsg-name "$NSG_NAME_ADMIN" \
  --name "AllowRDPAccess" \
  --priority 100 \
  --direction Inbound \
  --access Allow \
  --protocol Tcp \
  --destination-port-range 3389 \
  --source-address-prefix "$ADMIN_IP_RANGE" \
  --destination-address-prefix "*" \
  --description "Allow RDP administrative access"

# Allow SSH (Port 22) access for admins
az network nsg rule create \
  --resource-group "$RESOURCE_GROUP_EU" \
  --nsg-name "$NSG_NAME_ADMIN" \
  --name "AllowSSHAccess" \
  --priority 101 \
  --direction Inbound \
  --access Allow \
  --protocol Tcp \
  --destination-port-range 22 \
  --source-address-prefix "$ADMIN_IP_RANGE" \
  --destination-address-prefix "*" \
  --description "Allow SSH administrative access"

# Deny all other inbound traffic to the admin subnet
az network nsg rule create \
  --resource-group "$RESOURCE_GROUP_EU" \
  --nsg-name "$NSG_NAME_ADMIN" \
  --name "DenyAllOtherInboundAdmin" \
  --priority 4096 \
  --direction Inbound \
  --access Deny \
  --protocol "*" \
  --destination-port-range "*" \
  --source-address-prefix "*" \
  --destination-address-prefix "*" \
  --description "Deny all other inbound traffic to admin subnet"

# Apply NSG to the admin subnet in EU
echo "Associating NSG with admin subnet in EU..."
az network vnet subnet update \
  --resource-group "$RESOURCE_GROUP_EU" \
  --vnet-name "$VNET_NAME_EU" \
  --name "$SUBNET_NAME_EU_2" \
  --network-security-group "$NSG_NAME_ADMIN"

# ---------------------------------
# NSG for US Region (File Server Access)
# ---------------------------------

echo "Creating Network Security Group for US VNET..."
az network nsg create \
  --resource-group "$RESOURCE_GROUP_US" \
  --name "$NSG_NAME_US" \
  --location "$LOCATION_US"

# Allow outbound SMB (Port 445) to EU file server
az network nsg rule create \
  --resource-group "$RESOURCE_GROUP_US" \
  --nsg-name "$NSG_NAME_US" \
  --name "AllowSMBOutboundToEU" \
  --priority 100 \
  --direction Outbound \
  --access Allow \
  --protocol Tcp \
  --destination-port-range 445 \
  --source-address-prefix "*" \
  --destination-address-prefix "10.3.1.0/24" \
  --description "Allow SMB outbound to EU file server"

# Allow outbound HTTP (Port 80) and HTTPS (Port 443) to the EU web service
az network nsg rule create \
  --resource-group "$RESOURCE_GROUP_US" \
  --nsg-name "$NSG_NAME_US" \
  --name "AllowHTTPHTTPSOutboundToEU" \
  --priority 200 \
  --direction Outbound \
  --access Allow \
  --protocol Tcp \
  --destination-port-range 80 443 \
  --source-address-prefix "*" \
  --destination-address-prefix "10.3.1.0/24" \
  --description "Allow HTTP and HTTPS outbound to EU web service"

#!/bin/bash

# Variables
RESOURCE_GROUP_EU="tech_task-WP01--RG_EU_West"
NSG_NAME="tech_task-WP01--AdminNSG"  # Name of the NSG for EU region
EU_SUBNET_PREFIX="10.3.1.0/24"  # Replace with your Europe subnet IP range
STORAGE_SERVICE_TAG="Storage"

# Allow SMB traffic (Port 445) for Europe users
echo "Adding rule to allow SMB access for Europe users..."
az network nsg rule create \
  --resource-group "$RESOURCE_GROUP_EU" \
  --nsg-name "$NSG_NAME" \
  --name "AllowSMBForEuropeUsers" \
  --priority 230 \
  --direction Inbound \
  --access Allow \
  --protocol Tcp \
  --source-address-prefix "$EU_SUBNET_PREFIX" \
  --source-port-range "*" \
  --destination-address-prefix "$STORAGE_SERVICE_TAG" \
  --destination-port-range 445 \
  --description "Allow SMB traffic from Europe users to storage account"

# Allow SMB traffic (Port 445) - for SMB file share using Storage service tag
echo "Adding rule to allow SMB traffic (port 445)..."
az network nsg rule create \
  --resource-group "$RESOURCE_GROUP_EU" \
  --nsg-name "$NSG_NAME" \
  --name "AllowSMB" \
  --priority 200 \
  --direction Inbound \
  --access Allow \
  --protocol Tcp \
  --source-address-prefix "*" \
  --source-port-range "*" \
  --destination-address-prefix "$STORAGE_SERVICE_TAG" \
  --destination-port-range 445 \
  --description "Allow SMB traffic for file share"

# Allow NFS traffic (Port 2049) - for NFS file share using Storage service tag
echo "Adding rule to allow NFS traffic (port 2049)..."
az network nsg rule create \
  --resource-group "$RESOURCE_GROUP_EU" \
  --nsg-name "$NSG_NAME" \
  --name "AllowNFS" \
  --priority 210 \
  --direction Inbound \
  --access Allow \
  --protocol Tcp \
  --source-address-prefix "*" \
  --source-port-range "*" \
  --destination-address-prefix "$STORAGE_SERVICE_TAG" \
  --destination-port-range 2049 \
  --description "Allow NFS traffic for file share"

# Allow outbound traffic to the storage account
echo "Adding rule to allow outbound traffic to the storage account..."
az network nsg rule create \
  --resource-group "$RESOURCE_GROUP_EU" \
  --nsg-name "$NSG_NAME" \
  --name "AllowOutboundToStorage" \
  --priority 220 \
  --direction Outbound \
  --access Allow \
  --protocol "*" \
  --source-address-prefix "*" \
  --source-port-range "*" \
  --destination-address-prefix "$STORAGE_SERVICE_TAG" \
  --destination-port-range "*" \
  --description "Allow outbound traffic to storage account"

# Apply NSG to the US subnets
echo "Associating NSG with US subnets..."
az network vnet subnet update \
  --resource-group "$RESOURCE_GROUP_US" \
  --vnet-name "$VNET_NAME_US" \
  --name "$SUBNET_NAME_US_1" \
  --network-security-group "$NSG_NAME_US"

az network vnet subnet update \
  --resource-group "$RESOURCE_GROUP_US" \
  --vnet-name "$VNET_NAME_US" \
  --name "$SUBNET_NAME_US_2" \
  --network-security-group "$NSG_NAME_US"