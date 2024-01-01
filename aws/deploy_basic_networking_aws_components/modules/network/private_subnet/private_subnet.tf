resource "aws_subnet" "private" {
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
}

resource "aws_route_table" "private" {
  vpc_id = "${var.vpc_id}"
  count  = "${length(var.cidrs)}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${var.nat_gateway_id}"
  }

  tags = {
    Name = "${var.name}.terraform.${var.environment}.${var.azs[count.index]}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table_association" "private" {
  count          = "${length(var.cidrs)}"
  subnet_id      = "${aws_subnet.private.*.id[count.index]}"
  route_table_id = "${aws_route_table.private.*.id[count.index]}"

  lifecycle {
    create_before_destroy = true
  }
}
