variable "environment" {}

variable "vpc_cidr" {}

variable "azs" {
  type = list(string)
}

variable "region" {}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "key_name" {}

variable "bastion_instance_type" {}

variable "source_ssh_ips" {
  type = list(string)
}

variable "bastion_ami" {}
