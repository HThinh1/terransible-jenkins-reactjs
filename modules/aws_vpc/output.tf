output "vpc_id" {
  value = "${aws_vpc.devops_vpc.id}"
}
output "aws_public_subnet_id" {
  value = "${aws_subnet.devops_public_subnet.id}"
}
output "aws_private_subnet_id" {
  value = "${aws_default_route_table.devops_private_rt.id}"
}