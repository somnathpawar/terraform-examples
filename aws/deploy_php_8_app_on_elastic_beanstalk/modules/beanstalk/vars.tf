variable "environment_name" {
  type = string
}

variable "eb_application_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ec2_subnets" {
  type = string
}

variable "elb_subnets" {
  type = list(string)
}

variable "eb_instance_type" {
  type = string
}

variable "eb_instance_min_size" {
  type = number
}

variable "eb_instance_max_size" {
  type = number
}

variable "eb_instance_disk_size" {
  type = string
}

variable "keypair" {
  type = string
}

variable "certificate" {
  type = string
}

variable "eb_instance_ssh_restrict" {
  type = string
}