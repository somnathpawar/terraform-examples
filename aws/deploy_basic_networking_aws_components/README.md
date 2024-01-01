# Deploy AWS basic networking components

### Prerequisite Steps
- Set up a SSH key for  you & update value for public_key into "dev/terraform.tfvars" file:
  ```bash
  ssh-keygen -t ed25519 -f terraformation-v2-dev
  ```
- Update "dev/terraform.tfvars" file with your project configuration, such as region, terraform user profile you use on AWS credentials file, bastion AMI, instance type, VPC, subnet CIDR etc.
- Make sure you got `terraform_aws_profile` profile into your `~/.aws/credentials` file where you maintain the AWS account programatic access profiles. Or you can point your own AWS profile from that config.
- Update your environment specific for S3 bucket configuration to store the Terraform state file remotely on AWS S3 instead of keeping it locally or into code repository. e.g. In this codebase, dev is the environment, so you can find dev/main.tf file with S3 backend configured.
- You can add envrionment specific folders such as `dev` over here and adjust the required configuration for it.
