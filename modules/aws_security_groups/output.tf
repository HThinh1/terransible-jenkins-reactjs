output "public_sg_id" {
  value = "${aws_security_group.devops_public_sg.id}"
}

output "jenkins_sg_id" {
  value = "${aws_security_group.jenkins_private_sg.id}"
}


output "private_sg_id" {
  value = "${aws_security_group.devops_private_sg.id}"
}
