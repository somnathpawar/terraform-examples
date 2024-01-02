terraform {
  backend "s3" {
    bucket  = "terraform-dev-env-state-files"
    key     = "terraform-dev-state.tfstate"
    region  = "us-east-1"
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

module "sns" {
  source = "../modules/sns"

  environment_name      = var.environment_name
  eb_sns_user_email     = "${var.eb_sns_user_email}"
}

module "dns_and_ssl" {
  source = "../modules/dns_and_ssl/"

  domain_name                                           = var.domain_name
  eb_env_domain_name                                    = var.eb_env_domain_name
  cname                                                 = module.eb.cname
  zone                                                  = module.eb.zone
}

module "eb" {
  source = "../modules/beanstalk/"

  environment_name                  = var.environment_name
  eb_application_name               = var.eb_application_name
  vpc_id                            = "${module.network.vpc_id}"
  ec2_subnets                       = join(", ", flatten("${module.network.public_subnet_ids}"))
  elb_subnets                       = "${module.network.public_subnet_ids}"
  eb_instance_type                  = var.eb_instance_type
  eb_instance_min_size              = var.eb_instance_min_size
  eb_instance_max_size              = var.eb_instance_max_size
  eb_instance_disk_size             = var.eb_instance_disk_size
  keypair                           = aws_key_pair.terraformation.key_name
  eb_instance_ssh_restrict          = var.eb_instance_ssh_restrict
  certificate                       = module.dns_and_ssl.certificate
}



module "cloudwatch" {
  source = "../modules/cloudwatch/"

  environment_name                                      = var.environment_name
  eb_alarm_sns_topic                                    = module.sns.sns_topic_arn
  asgName                                               = module.eb.asgName
  envName                                               = module.eb.envName
  lbarn                                                 = module.eb.lbarn
}