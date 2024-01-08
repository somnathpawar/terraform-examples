# Deploy AWS basic networking components

This boilerplate helps creating following AWS networking components:
- 1 VPC
- 6 Subnets (3 public, 3 private)
- 1 Internet Gateway
- 3 NAT Gateways
- 6 Route Tables & Associations with Subnets
- 1 Security Group
- 1 Network ACL
- 1 AWS Key Pairs
- 1 VPC S3 Endpoint
- 1 EC2 Bastion Instance
- 1 Cloudwatch metrics
- 1 SNS topic & email subscription
- 1 SSL certificate for EB envrionment

### Prerequisite Steps
- Set up a SSH key for  you & update value for public_key into "dev/terraform.tfvars" file:
  ```bash
  ssh-keygen -t ed25519 -f terraformation-v2-dev
  ```
- Update "dev/terraform.tfvars" file with your project configuration, such as region, terraform user profile you use on AWS credentials file, bastion AMI, instance type, VPC, subnet CIDR etc.
- Make sure you got `terraform_aws_profile` profile into your `~/.aws/credentials` file where you maintain the AWS account programatic access profiles. Or you can point your own AWS profile from that config.
- Update your environment specific for S3 bucket configuration to store the Terraform state file remotely on AWS S3 instead of keeping it locally or into code repository. e.g. In this codebase, dev is the environment, so you can find dev/main.tf file with S3 backend configured.
- You can add envrionment specific folders such as `stage`, `prod` etc over here and adjust the required configuration for them.

- You can now run the Terraform commands:
  ```bash
  terraform init
  ```
  ```bash
  terraform plan
  ```
  ```bash
  terraform apply
  ```

**That's it!** You are up with the main networking components & elastic beanstalk environment with a sample PHP application on AWS.
