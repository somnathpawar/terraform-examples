# General
environment = "dev"
name = "terraform-aws"
profile = "terraform_aws_profile"
region = "us-east-1"
key_name = "terraformation-dev"
public_key = "YourSSHPublicKey"
default_ami = "ami-079db87dc4c10ac91"

# Network
vpc_cidr = "10.105.0.0/16"
azs = ["us-east-1a","us-east-1b","us-east-1c"]
public_subnets  = ["10.105.221.0/24","10.105.222.0/24","10.105.223.0/24"] # Creating one public subnet per AZ
private_subnets = ["10.105.231.0/24","10.105.232.0/24","10.105.233.0/24"] # Creating one private subnet per AZ
bastion_instance_type = "t2.micro"
source_ssh_ips = ["103.197.75.232/32", "103.197.75.191/32"]

# Elastic Beanstalk Environment
domain_name    = "YourRoute53DomainName.com"
eb_env_domain_name = "YourEBDomainName.com"
environment_name = "boilerplate"
eb_application_name = "boilerplate-app"
eb_instance_type = "t3.micro"
eb_instance_disk_size = "20"
eb_instance_min_size = "1"
eb_instance_max_size = "2"
eb_instance_ssh_restrict="12.34.56.78/32"
eb_alarm_sns_topic = ""
eb_sns_user_email = "YourSNSEmailAddress"
