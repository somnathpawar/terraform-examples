terraform {
  backend "s3" {
    bucket  = "terraform-dev-env-state"
    key     = "terraform-dev-state.tfstate"
    region  = "us-east-2"
    profile = "terraform_aws_profile"
  }
}

provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}

resource "aws_key_pair" "terraformation" {
  key_name   = "${var.key_name}"
  public_key = "${var.public_key}"

  lifecycle {
    create_before_destroy = true
  }
}

module "network" {
  source = "../modules/network"

  environment           = "${var.environment}"
  vpc_cidr              = "${var.vpc_cidr}"
  region                = "${var.region}"
  azs                   = "${var.azs}"
  public_subnets        = "${var.public_subnets}"
  private_subnets       = "${var.private_subnets}"
  key_name              = "${var.key_name}"
  bastion_instance_type = "${var.bastion_instance_type}"
  bastion_ami           = "${var.default_ami}"
  source_ssh_ips        = "${var.source_ssh_ips}"
}