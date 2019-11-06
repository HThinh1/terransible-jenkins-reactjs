resource "aws_autoscaling_policy" "scaleup" {
  name                   = "scaleup"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${var.asg_name}"
}

resource "aws_cloudwatch_metric_alarm" "scaleup" {
  alarm_name          = "scaleup"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "70"

  alarm_description = "Scale up when EC2 instances pass threshold"
  alarm_actions     = ["${aws_autoscaling_policy.scaleup.arn}"]

  dimensions = {
    AutoScalingGroupName = "${var.asg_name}"
  }
}

resource "aws_autoscaling_policy" "scaledown" {
  name                   = "scaledown"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${var.asg_name}"
}

resource "aws_cloudwatch_metric_alarm" "scaledown" {
  alarm_name          = "scaledown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  alarm_description = "Scale down when EC2 instances pass threshold"
  alarm_actions     = ["${aws_autoscaling_policy.scaledown.arn}"]

  dimensions = {
    AutoScalingGroupName = "${var.asg_name}"
  }
}
