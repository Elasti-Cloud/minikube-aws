# Main
variable "profile" {
  description = "Name of the local AWS profile"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "admin_ip" {
  description = "IP or IP range for the admin clients"
  type        = string
}

variable "network" {
  description = "CIDR for VPC, CIDR public subnet"
}

variable "inst_params" {
  description = "AMIs to use. Make sure to align with a region"
}

variable "tags" {
  description = "Dictionary of tags"
  type        = map(string)
}