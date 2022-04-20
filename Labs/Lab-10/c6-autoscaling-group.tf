#autoscaling group

resource "aws_autoscaling_group" "autoscalinggroup" {
  name = "autoscaling-group"
  vpc_zone_identifier = [aws_subnet.vpc-subnet-1.id]
  launch_configuration = aws_launch_configuration.autoscaling-launch-Configuration.name
  health_check_type = "EC2"
  min_size = 1
  max_size = 2
  health_check_grace_period = 300
  force_delete = true
}

#launch Configuration
resource "aws_launch_configuration" "autoscaling-launch-Configuration" {
  name_prefix = "autoscaling-launch-Configuration"
  image_id = var.ec2_ami_id
  instance_type = var.instance_type
  key_name = "terraform-key"
  security_groups = [aws_security_group.dev-vpc-sg.id]
  #count=2
}

#policy for scale up
resource "aws_autoscaling_policy" "scale-up-aws-autoscaling-policy" {
  name = "scale-up-aws-autoscaling-policy"
  autoscaling_group_name = aws_autoscaling_group.autoscalinggroup.name
  adjustment_type = "ChangeInCapacity" #ExactCapacity
  scaling_adjustment = "1"  #postive value will increse the capacity
  cooldown = "300"  # amount of time .Unit will be seconds
  policy_type = "SimpleScaling"
}

#policy for scale down
resource "aws_autoscaling_policy" "scale-down-aws-autoscaling-policy" {
  name = "scale-down-aws-autoscaling-policy"
  autoscaling_group_name = aws_autoscaling_group.autoscalinggroup.name
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = "-1"
  cooldown = "300"
  policy_type = "SimpleScaling"
}

#alarm for scale up
resource "aws_cloudwatch_metric_alarm" "autoscaling-alarm-scaleup" {
  alarm_name = "autoscaling-alarm-scaleup"
  alarm_description = "autoscaling alarm for scaleup"
  metric_name = "CPUUtilization"
  period = "120" #seconds
  threshold = "30"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 1
  alarm_actions = [aws_autoscaling_policy.scale-up-aws-autoscaling-policy.arn]
  actions_enabled = true
  statistic = "Average"
  namespace = "AWS/EC2"
  dimensions = {
    "Autoscalinggroupname" = aws_autoscaling_group.autoscalinggroup.name
  }
}

#alarm for scale down
resource "aws_cloudwatch_metric_alarm" "autoscaling-alarm-scaledown" {
  alarm_name = "autoscaling-alarm-scaledown"
  alarm_description = "autoscaling alarm for scaledown"
  metric_name = "CPUUtilization"
  period = "120" #seconds
  threshold = "5"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = 1
  alarm_actions = [aws_autoscaling_policy.scale-up-aws-autoscaling-policy.arn]
  actions_enabled = true
  statistic = "Average"
  namespace = "AWS/EC2"
   dimensions = {
    "Autoscalinggroupname" = aws_autoscaling_group.autoscalinggroup.name
  }
}

