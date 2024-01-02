resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.name}"
    environment = "${var.environment}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
