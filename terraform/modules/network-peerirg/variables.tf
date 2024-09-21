variable "name" {
  type = string
  default = "client-test-1"
  description = "value"
}

variable "virtual_network_name" {
    type = string
    default = "rg_azure-vnet"
}

variable "resource_group_name" {
    type = string
    default = "rg_azure"
}

variable "remote_virtual_network_id" {
    type = string
    default = "default"
}