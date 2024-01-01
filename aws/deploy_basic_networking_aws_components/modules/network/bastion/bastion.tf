resource "aws_eip" "bastion" {
  instance = "${aws_instance.bastion.id}"
  domain      = "vpc"
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = "${aws_instance.bastion.id}"
  allocation_id = "${aws_eip.bastion.id}"
}

resource "aws_security_group" "bastion" {
  name        = "${var.name}"
  vpc_id      = "${var.vpc_id}"
  description = "Bastion security group"

  tags = {
    Name        = "${var.name}"
    type        = "${var.name}"
    environment = "${var.environment}"
  }

  lifecycle {
    create_before_destroy = true
  }

  ingress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  # SG rule for SSH access from Cogniance only
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.source_ssh_ips}"
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "bastion" {
  ami                         = "${var.ami}"
  instance_type               = "${var.instance_type}"
  subnet_id                   = "${var.public_subnet_ids[0]}"
  key_name                    = "${var.key_name}"
  vpc_security_group_ids      = ["${aws_security_group.bastion.id}"]
  user_data                   = "${file("../modules/network/bastion/userdata.sh")}"
  associate_public_ip_address = true

  tags = {
    Name        = "${var.name}"
    environment = "${var.environment}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
