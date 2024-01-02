variable "name" {
  default = "public"
}

variable "environment" {}

variable "vpc_id" {}

variable "cidrs" {
  type = list(string)
}

variable "azs" {
  type = list(string)
}
