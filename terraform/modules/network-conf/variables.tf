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