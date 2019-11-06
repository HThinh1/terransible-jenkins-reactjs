output "react_instance_id" {
  value = "${aws_instance.reactjs_instance.id}"
}
output "jenkins_instance_id" {
  value = "${aws_instance.jenkins_instance.id}"
}

output "keypair_auth_id" {
  value = "${aws_key_pair.keypair_auth.id}"
}
