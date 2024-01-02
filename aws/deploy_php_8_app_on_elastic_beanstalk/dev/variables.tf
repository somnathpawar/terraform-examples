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

variable "domain_name" {}

variable "eb_env_domain_name" {}

variable "environment_name" {}

variable "eb_application_name" {}

variable "eb_instance_type" {}

variable "eb_instance_min_size" {}

variable "eb_instance_max_size" {}

variable "eb_instance_disk_size" {}

variable "eb_instance_ssh_restrict" {}

variable "eb_alarm_sns_topic" {}

variable "eb_sns_user_email" {}

