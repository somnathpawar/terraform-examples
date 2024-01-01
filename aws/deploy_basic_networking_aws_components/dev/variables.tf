variable "environment" {}

variable "region" {}

variable "vpc_cidr" {}

variable "name" {}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "default_ami" {}

variable "azs" {
  type = list(string)
}

variable "profile" {}

variable "key_name" {}

variable "public_key" {}

variable "bastion_instance_type" {}

variable "source_ssh_ips" {
  type = list(string)
}