resource "random_id" "unique_aim_id" {
  byte_length = 3
}

resource "aws_ami_from_instance" "react_ami" {
  name               = "${var.PROJECT_NAME}_ami-${random_id.unique_aim_id.b64}"
  source_instance_id = "${var.react_instance_id}"
}

resource "aws_launch_configuration" "react_lc" {
  name_prefix     = "${var.PROJECT_NAME}_react_lc"
  image_id        = "${aws_ami_from_instance.react_ami.id}"
  instance_type   = "${var.lc_instance_type}"
  security_groups = ["${var.web_dev_sg_id}"]
  key_name        = "${var.keypair_auth_id}"

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "asg" {
  name                      = "${var.PROJECT_NAME}_asg"
  max_size                  = "${var.asg_max_size}"
  min_size                  = "${var.asg_min_size}"
  health_check_grace_period = "${var.asg_grace}"
  health_check_type         = "${var.asg_hct}"
  desired_capacity          = "${var.asg_cap}"
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.react_lc.id}"
  vpc_zone_identifier       = ["${var.public_subnet_id}", "${var.public1_subnet_id}"]
  target_group_arns         = ["${var.target_group_arn}"]
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name"
    value               = "${var.PROJECT_NAME}_asg"
    propagate_at_launch = true
  }
}
resource "aws_autoscaling_attachment" "auto_scaling_attachment" {
  autoscaling_group_name = "${aws_autoscaling_group.asg.name}"
  alb_target_group_arn   = "${var.alb_target_group_arn}"
}
