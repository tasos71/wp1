variable "name" {
  type        = string
  default     = "my-storage-account"
  description = "Name of the storage account"
}

variable "location" {
  type        = string
  default     = "eastus"
  description = "The Azure Region in which all resources in this example should be created."
}

variable "resource_group_name" {
  type        = string
  default     = "rg-avd-storage"
  description = "Name of the Resource group in which to deploy storage"
}

variable "avd_users" {
  description = "AVD users"
  default = [
    "avduser01@contoso.net",
    "avduser02@contoso.net"
  ]
}

variable "aad_group_name" {
  type        = string
  default     = "AVDUsers"
  description = "Azure Active Directory Group for AVD users"
}