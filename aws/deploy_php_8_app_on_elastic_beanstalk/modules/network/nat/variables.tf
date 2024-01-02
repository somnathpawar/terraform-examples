variable "name" {
  default = "nat"
}

variable "azs" {}

variable "public_subnet_ids" {
  type = list(string)
}
