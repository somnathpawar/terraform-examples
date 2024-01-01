resource "aws_vpc_endpoint" "private-s3" {
  vpc_id          = "${var.vpc_id}"
  service_name    = "com.amazonaws.us-east-2.s3"
  route_table_ids = flatten(["${var.route_table_ids}"])
}
