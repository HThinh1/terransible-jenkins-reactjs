resource "aws_security_group" "devops_public_sg" {
  name = "devops_public_sg"
  description = "Used for public access"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.localip}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "jenkins_private_sg" {
  name = "jenkins_private_sg"
  description = "Used for private access"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["${var.localip}"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.localip}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "devops_private_sg" {
  name = "devops_private_sg"
  description = "Used for private access"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 0
    to_port = 0
    protocol ="-1"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
