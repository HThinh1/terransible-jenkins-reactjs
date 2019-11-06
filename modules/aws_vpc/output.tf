output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}
output "public_subnet_id" {
  value = "${aws_subnet.public_subnet.id}"
}
output "public1_subnet_id" {
  value = "${aws_subnet.public_subnet1.id}"
}
output "private_subnet_id" {
  value = "${aws_default_route_table.private_rt.id}"
}
output "private1_subnet_id" {
  value = "${aws_subnet.private_subnet1.id}}"
}
