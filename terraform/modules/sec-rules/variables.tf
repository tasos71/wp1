variable "name"{
  type = string
  default = "my-sec-rule"
}

variable "priority"{
  type = string
  default = "100"
}

variable "direction"{
  type = string
  default = "InBound"
}

variable "access"{
  type = string
  default = "Deny"
}

variable "protocol"{
  type = string
  default = "Tcp"
}

variable "source_port_range"{
  type = string
  default = "65500"
}

variable "destination_port_range"{
  type = string
  default = "65500"
}

variable "source_address_prefix"{
  type = string
  default = "10.0.0.1/16"
}

variable "destination_address_prefix"{
  type = string
  default = "client-test-1"
}

variable "description"{
  type = string
  default = "client-test-1"
}

variable "resource_group_name"{
  type = string
  default = "client-test-1"
}

variable "network_security_group_name"{
  type = string
  default = "client-test-1"
}