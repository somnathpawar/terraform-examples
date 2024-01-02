module "vpc" {
  source = "./vpc"

  environment = "${var.environment}"
  name        = "vpc-terraform-${var.environment}"
  vpc_cidr    = "${var.vpc_cidr}"
}

module "public_subnet" {
  source = "./public_subnet"

  name   = "public"
  vpc_id = "${module.vpc.vpc_id}"
  cidrs  = "${var.public_subnets}"
  azs    = "${var.azs}"
  environment = "${var.environment}"
}

module "bastion" {
  source = "./bastion"

  environment       = "${var.environment}"
  name              = "bastion"
  vpc_id            = "${module.vpc.vpc_id}"
  vpc_cidr          = "${module.vpc.vpc_cidr}"
  region            = "${var.region}"
  public_subnet_ids = "${module.public_subnet.subnet_ids}"
  key_name          = "${var.key_name}"
  instance_type     = "${var.bastion_instance_type}"
  ami               = "${var.bastion_ami}"
  source_ssh_ips    = "${var.source_ssh_ips}"
}

module "nat" {
  source = "./nat"

  name              = "nat"
  azs               = "${var.azs}"
  public_subnet_ids = "${module.public_subnet.subnet_ids}"
}

module "private_subnet" {
  source = "./private_subnet"

  name   = "private"
  vpc_id = "${module.vpc.vpc_id}"
  cidrs  = "${var.private_subnets}"
  azs    = "${var.azs}"
  environment = "${var.environment}"

  nat_gateway_id = "${module.nat.nat_gateway_id}"
}

module "s3_endpoint_private" {
  source = "./s3_endpoint"

  vpc_id          = "${module.vpc.vpc_id}"
  route_table_ids = "${module.private_subnet.route_table_ids}"
}

resource "aws_network_acl" "acl" {
  vpc_id     = "${module.vpc.vpc_id}"

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "all"
  }
}
