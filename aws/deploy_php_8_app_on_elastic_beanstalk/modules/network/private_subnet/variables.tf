variable "name" {
  default = "private"
}
variable "environment" {}

variable "vpc_id" {}

variable "cidrs" {
  type = list(string)
}

variable "azs" {
  type = list(string)
}

variable "nat_gateway_id" {}
