output "web_dev_sg_id" {
  value = "${aws_security_group.web_dev_sg.id}"
}
output "jenkins_sg_id" {
  value = "${aws_security_group.jenkins_sg.id}"
}
