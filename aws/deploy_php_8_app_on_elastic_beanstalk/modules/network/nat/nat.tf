resource "aws_eip" "nat" {
  domain = "vpc"

  count = "${length(var.azs)}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.nat.*.id[count.index]}"
  subnet_id     = "${var.public_subnet_ids[count.index]}"

  count = "${length(var.azs)}"

  lifecycle {
    create_before_destroy = true
  }
}
