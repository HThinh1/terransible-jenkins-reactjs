output "react_lc" {
  value = "${aws_launch_configuration.react_lc.name}"
}
output "asg_name" {
  value = "${aws_autoscaling_group.asg.name}"
}
output "asg_arn" {
  value = "${aws_autoscaling_group.asg.arn}"
}
