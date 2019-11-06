resource "aws_alb" "alb" {
  name               = "${var.PROJECT_NAME}-alb"
  subnets            = ["${var.public_subnet_id}", "${var.public1_subnet_id}"]
  security_groups    = ["${var.web_dev_sg_id}"]
  internal           = false
  load_balancer_type = "application"
  idle_timeout       = 400
  tags = {
    "Name" = "${var.PROJECT_NAME} Application Load Balancer"
  }
}
resource "aws_alb_listener" "alb_http" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = "${aws_alb_target_group.target_group_http.arn}"
    type             = "forward"
  }
}
resource "aws_alb_target_group" "target_group_http" {
  name        = "${var.PROJECT_NAME}-alb-tg"
  port        = "80"
  protocol    = "HTTP"
  vpc_id      = "${var.vpc_id}"
  target_type = "instance"
  health_check {
    healthy_threshold   = "3"
    unhealthy_threshold = "10"
    timeout             = "20"
    interval            = "30"
    path                = "/"
    port                = "80"
  }
}

resource "aws_lb_target_group_attachment" "alb_tg_attachment" {
  count            = 2
  target_group_arn = "${aws_alb_target_group.target_group_http.arn}"
  target_id        = "${var.react_instance_id}"
  port             = "80"
}
