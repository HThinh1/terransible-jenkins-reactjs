output "alb_arn" {
  value = "${aws_alb.alb.arn}"
}
output "alb_id" {
  value = "${aws_alb.alb.id}"
}
output "dns_name" {
  value = "${aws_alb.alb.dns_name}"
}
output "target_group_arn" {
  value = "${aws_alb_target_group.target_group_http.arn}"
}
output "elb_arn_suffix" {
  value = "${aws_alb.alb.arn_suffix}"
}
output "target_group_arn_suffix" {
  value = "${aws_alb_target_group.target_group_http.arn_suffix}"
}
output "zone_id" {
  value = "${aws_alb.alb.zone_id}"
}
