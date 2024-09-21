#!/bin/bash

# Variables
RESOURCE_GROUP_EU="tech_task-WP01--RG_EU_West"
STORAGE_ACCOUNT_NAME="fileshare$(date +%s | cut -c1-5)"  # Shorter, valid storage account name
LOCATION_EU="westeurope"
VNET_NAME="tech_task-WP01--VNet_EU_West"
SUBNET_NAME="tech_task-WP01--Subnet_EU_West1"
SMB_ENABLED=true   # Set to true or false to enable/disable SMB share creation
NFS_ENABLED=true   # Set to true or false to enable/disable NFS share creation

# File Share Names (you can change these)
SMB_SHARE_NAME="smbshare"
NFS_SHARE_NAME="nfsshare"

# Step 1: Add Microsoft.Storage Service Endpoint to the Subnet (Required for NFS)
echo "Adding Microsoft.Storage service endpoint to the subnet..."
az network vnet subnet update \
  --name "$SUBNET_NAME" \
  --vnet-name "$VNET_NAME" \
  --resource-group "$RESOURCE_GROUP_EU" \
  --service-endpoints "Microsoft.Storage"

# Step 2: Create the Storage Account with Private Network Access Only
echo "Creating storage account with private network access in $LOCATION_EU..."
az storage account create \
  --name "$STORAGE_ACCOUNT_NAME" \
  --resource-group "$RESOURCE_GROUP_EU" \
  --location "$LOCATION_EU" \
  --sku Premium_LRS \
  --kind FileStorage \
  --default-action Deny  # Deny public access to the storage account

# Step 3: Add VNet Rule for Storage Account (Required for NFS)
echo "Adding VNet rule to restrict access to the storage account..."
az storage account network-rule add \
  --resource-group "$RESOURCE_GROUP_EU" \
  --account-name "$STORAGE_ACCOUNT_NAME" \
  --vnet-name "$VNET_NAME" \
  --subnet "$SUBNET_NAME"

# Step 4: Disable 'Secure Transfer Required' (Required for NFS)
echo "Disabling 'Secure Transfer Required' for NFS access..."
az storage account update \
  --name "$STORAGE_ACCOUNT_NAME" \
  --resource-group "$RESOURCE_GROUP_EU" \
  --https-only false  # Disables 'Secure Transfer Required'

# Step 5: Create SMB File Share (Optional)
if [ "$SMB_ENABLED" = true ]; then
  echo "Creating SMB file share..."
  az storage share-rm create \
    --resource-group "$RESOURCE_GROUP_EU" \
    --storage-account "$STORAGE_ACCOUNT_NAME" \
    --name "$SMB_SHARE_NAME" \
    --quota 100  # Size in GiB
  echo "SMB file share '$SMB_SHARE_NAME' created."
else
  echo "SMB file share creation skipped."
fi

# Step 6: Create NFS File Share (Optional)
if [ "$NFS_ENABLED" = true ]; then
  echo "Creating NFS file share..."
  az storage share-rm create \
    --resource-group "$RESOURCE_GROUP_EU" \
    --storage-account "$STORAGE_ACCOUNT_NAME" \
    --name "$NFS_SHARE_NAME" \
    --enabled-protocol NFS \
    --root-squash NoRootSquash \
    --quota 100  # Size in GiB
  echo "NFS file share '$NFS_SHARE_NAME' created."
else
  echo "NFS file share creation skipped."
fi

echo "Azure File Share deployment completed."