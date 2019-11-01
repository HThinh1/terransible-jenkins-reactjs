resource "aws_key_pair" "devops_auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "reactjs_instance" {
  instance_type = "${var.instance_type}"
  ami = "${var.ami_id}"
  key_name = "${aws_key_pair.devops_auth.id}"
  vpc_security_group_ids = ["${var.public_sg_id}"]
  subnet_id = "${var.public_subnet_id}"

  provisioner "local-exec" {
    command = <<EOD
cat <<EOF > ../scripts/aws_react_hosts
[reactjs]
${aws_instance.reactjs_instance.public_ip}
EOF
EOD
  }

  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --instance-ids ${aws_instance.reactjs_instance.id} --profile devops && ansible-playbook -i ../scripts/aws_react_hosts ../scripts/reactjs.yml --extra-vars project_name=${var.project_name}"
  }

  tags {
    Name = "ReactJS Instance"
  }
}

resource "aws_instance" "jenkins_instance" {
  instance_type = "${var.instance_type}"
  ami = "${var.ami_id}"
  key_name = "${aws_key_pair.devops_auth.id}"
  vpc_security_group_ids = ["${var.jenkins_sg_id}"]
  subnet_id = "${var.public_subnet_id}"

  provisioner "local-exec" {
    command = <<EOD
cat <<EOF > ../scripts/aws_jenkins_hosts
[jenkins]
${aws_instance.jenkins_instance.public_ip}
EOF
EOD
  }

  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --instance-ids ${aws_instance.reactjs_instance.id} --profile devops && ansible-playbook -i ../scripts/aws_jenkins_hosts ../scripts/jenkins.yml"
  }

  tags {
    Name = "Jenkins Instance"
  }
}