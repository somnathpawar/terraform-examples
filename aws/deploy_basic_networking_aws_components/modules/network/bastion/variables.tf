variable "name" {
  default = "bastion"
}

variable "environment" {}

variable "vpc_id" {}

variable "vpc_cidr" {}

variable "region" {}

variable "public_subnet_ids" {
  type = list(string)
}

variable "key_name" {}

variable "instance_type" {}

variable "source_ssh_ips" {
  type = list(string)
}

variable "ami" {}
