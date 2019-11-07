resource "aws_key_pair" "keypair_auth" {
  key_name   = "${var.PROJECT_NAME}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "reactjs_instance" {
  instance_type          = "${var.instance_type}"
  ami                    = "${var.ami_id}"
  key_name               = "${aws_key_pair.keypair_auth.id}"
  vpc_security_group_ids = ["${var.web_dev_sg_id}"]
  subnet_id              = "${var.public_subnet_id}"

  provisioner "local-exec" {
    command = <<EOD
cat <<EOF > ../scripts/aws_react_hosts
[reactjs]
${aws_instance.reactjs_instance.public_ip}
EOF
EOD
  }

  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --instance-ids ${aws_instance.reactjs_instance.id} && ansible-playbook -i ../scripts/aws_react_hosts ../scripts/reactjs.yml --extra-vars PROJECT_NAME=${var.PROJECT_NAME}"
  }
  provisioner "local-exec" {
    command = "cd ../scm/github && terraform init && TF_VAR_PROJECT_NAME=${var.PROJECT_NAME} terraform apply -auto-approve"
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i ../scripts/aws_react_hosts ../scripts/git.yml -e PROJECT_NAME=${var.PROJECT_NAME} -e GITHUB_ORGANIZATION=$GITHUB_ORGANIZATION"
  }

  tags = {
    Name = "${var.PROJECT_NAME} ReactJS Instance"
  }
}

resource "aws_instance" "jenkins_instance" {
  instance_type          = "${var.instance_type}"
  ami                    = "${var.ami_id}"
  key_name               = "${aws_key_pair.keypair_auth.id}"
  vpc_security_group_ids = ["${var.jenkins_sg_id}"]
  subnet_id              = "${var.public_subnet_id}"

  provisioner "local-exec" {
    command = <<EOD
cat <<EOF > ../scripts/aws_jenkins_hosts
[jenkins]
${aws_instance.jenkins_instance.public_ip}
EOF
EOD
  }

  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --instance-ids ${aws_instance.reactjs_instance.id} && ansible-playbook -i ../scripts/aws_jenkins_hosts ../scripts/jenkins.yml --extra-vars PROJECT_NAME=${var.PROJECT_NAME}"
  }

  tags = {
    Name = "${var.PROJECT_NAME} Jenkins Instance"
  }
}
