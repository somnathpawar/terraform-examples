# VPC
output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "vpc_cidr" {
  value = "${module.vpc.vpc_cidr}"
}

# Subnets
output "public_subnet_ids" {
  value = "${module.public_subnet.subnet_ids}"
}

output "private_subnet_ids" {
  value = "${module.private_subnet.subnet_ids}"
}

# Bastion
output "bastion_user" {
  value = "${module.bastion.user}"
}

output "bastion_private_ip" {
  value = "${module.bastion.private_ip}"
}

output "bastion_public_ip" {
  value = "${module.bastion.public_ip}"
}

output "bastion_sg_id" {
  value = "${module.bastion.bastion_sg_id}"
}

# NAT
output "nat_gateway_ids" {
  value = "${module.nat.nat_gateway_id}"
}