#!/bin/bash
# Variables (fill in as needed)
RESOURCE_GROUP_US="tech_task-WP01--RG_US_West"
RESOURCE_GROUP_EU="tech_task-WP01--RG_EU_West"
LOCATION_US="westus"
LOCATION_EU="westeurope"
VNET_NAME_US="tech_task-WP01--VNet_US_West"
VNET_NAME_EU="tech_task-WP01--VNet_EU_West"
ADDRESS_PREFIX_VNET_US="10.2.0.0/16"
ADDRESS_PREFIX_VNET_EU="10.3.0.0/16"

# Optional Subnet Variables (leave empty if not needed)
SUBNET_NAME_US_1="tech_task-WP01--Subnet_US_West01"
ADDRESS_PREFIX_SUBNET_US_1="10.2.1.0/24"
SUBNET_NAME_US_2="tech_task-WP01--Subnet_US_West02"
ADDRESS_PREFIX_SUBNET_US_2="10.2.2.0/24"

SUBNET_NAME_EU_1="tech_task-WP01--Subnet_EU_West1"
ADDRESS_PREFIX_SUBNET_EU_1="10.3.1.0/24"
SUBNET_NAME_EU_2="tech_task-WP01--Subnet_EU_West2"
ADDRESS_PREFIX_SUBNET_EU_2="10.3.2.0/24"

# Step 1: Create Resource Groups
az group create --name $RESOURCE_GROUP_US --location $LOCATION_US
az group create --name $RESOURCE_GROUP_EU --location $LOCATION_EU

# Step 2: Create VNet in US-West
az network vnet create \
  --name $VNET_NAME_US \
  --resource-group $RESOURCE_GROUP_US \
  --location $LOCATION_US \
  --address-prefix $ADDRESS_PREFIX_VNET_US

# Step 3: Create VNet in West Europe
az network vnet create \
  --name $VNET_NAME_EU \
  --resource-group $RESOURCE_GROUP_EU \
  --location $LOCATION_EU \
  --address-prefix $ADDRESS_PREFIX_VNET_EU

# Step 4: Optional Subnet Creation in US-West

# Create US Subnet 1 if variables are provided
if [[ -n $SUBNET_NAME_US_1 && -n $ADDRESS_PREFIX_SUBNET_US_1 ]]; then
    az network vnet subnet create \
      --resource-group $RESOURCE_GROUP_US \
      --vnet-name $VNET_NAME_US \
      --name $SUBNET_NAME_US_1 \
      --address-prefix $ADDRESS_PREFIX_SUBNET_US_1
fi

# Create US Subnet 2 if variables are provided
if [[ -n $SUBNET_NAME_US_2 && -n $ADDRESS_PREFIX_SUBNET_US_2 ]]; then
    az network vnet subnet create \
      --resource-group $RESOURCE_GROUP_US \
      --vnet-name $VNET_NAME_US \
      --name $SUBNET_NAME_US_2 \
      --address-prefix $ADDRESS_PREFIX_SUBNET_US_2
fi

# Step 5: Optional Subnet Creation in West Europe

# Create EU Subnet 1 if variables are provided
if [[ -n $SUBNET_NAME_EU_1 && -n $ADDRESS_PREFIX_SUBNET_EU_1 ]]; then
    az network vnet subnet create \
      --resource-group $RESOURCE_GROUP_EU \
      --vnet-name $VNET_NAME_EU \
      --name $SUBNET_NAME_EU_1 \
      --address-prefix $ADDRESS_PREFIX_SUBNET_EU_1
fi

# Create EU Subnet 2 if variables are provided
if [[ -n $SUBNET_NAME_EU_2 && -n $ADDRESS_PREFIX_SUBNET_EU_2 ]]; then
    az network vnet subnet create \
      --resource-group $RESOURCE_GROUP_EU \
      --vnet-name $VNET_NAME_EU \
      --name $SUBNET_NAME_EU_2 \
      --address-prefix $ADDRESS_PREFIX_SUBNET_EU_2
fi

# Step 6: VNet Peering

# Peering from US VNet to EU VNet
az network vnet peering create \
  --name US-to-EU-Peering \
  --resource-group $RESOURCE_GROUP_US \
  --vnet-name $VNET_NAME_US \
  --remote-vnet "/subscriptions/$(az account show --query id -o tsv)/resourceGroups/$RESOURCE_GROUP_EU/providers/Microsoft.Network/virtualNetworks/$VNET_NAME_EU" \
  --allow-vnet-access

# Peering from EU VNet to US VNet
az network vnet peering create \
  --name EU-to-US-Peering \
  --resource-group $RESOURCE_GROUP_EU \
  --vnet-name $VNET_NAME_EU \
  --remote-vnet "/subscriptions/$(az account show --query id -o tsv)/resourceGroups/$RESOURCE_GROUP_US/providers/Microsoft.Network/virtualNetworks/$VNET_NAME_US" \
  --allow-vnet-access