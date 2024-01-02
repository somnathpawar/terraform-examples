resource "aws_internet_gateway" "public" {
  vpc_id = "${var.vpc_id}"

  tags = {
    Name = "${var.name}"
  }
}

resource "aws_subnet" "public" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.cidrs[count.index]}"
  availability_zone = "${var.azs[count.index]}"
  count             = "${length(var.cidrs)}"

  tags = {
    Name = "${var.name}.terraform.${var.environment}.${var.azs[count.index]}"
  }

  lifecycle {
    create_before_destroy = true
  }

  map_public_ip_on_launch = true
}

resource "aws_route_table" "public" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.public.id}"
  }

  tags = {
    Name = "${var.name}.terraform.${var.environment}.${var.azs[0]}"
  }
}

resource "aws_route_table_association" "public" {
  count          = "${length(var.cidrs)}"
  subnet_id      = "${aws_subnet.public.*.id[count.index]}"
  route_table_id = "${aws_route_table.public.id}"
}
