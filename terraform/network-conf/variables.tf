variable "resource_group" {
    type = string
    default = "my_resource_group"
    description = "Name of resource group"
}

variable "region" {
  type = string
  default = "my_region"
  description = "Azure Region"
}

variable "vpc_name" {
  type = string
  default = "client-test-1"
  description = "value"
}

variable "main_rg" {
    type = string
    default = "rg_azure"
}

variable "hub_vnet" {
    type = string
    default = "rg_azure-vnet"
}

variable "azure_dns_server" {
  type = string
  default = "1.1.1.1"
}

variable "remote_virtual_network_id" {
    type = string
    default = "default"
}

variable "main_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "subnet1" {
  type = string
  default = "10.0.1.0/24"
}

variable "subnet2" {
  type = string
  default = "10.0.2.0/24"
}