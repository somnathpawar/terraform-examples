output "user" {
  value = "centos"
}

output "bastion_sg_id" {
  value = "${aws_security_group.bastion.id}"
}

output "private_ip" {
  value = "${aws_instance.bastion.private_ip}"
}

output "public_ip" {
  value = "${aws_instance.bastion.public_ip}"
}

output "elastic_ip" {
  value = "${aws_eip.bastion.public_ip}"
}
