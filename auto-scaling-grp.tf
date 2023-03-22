resource "aws_autoscaling_group" "auto_scale" {
  name                = local.TAG_NAME
  vpc_zone_identifier = var.PRIVATE_SUBNET_ID
  desired_capacity   = var.AGS_DESIRED
  max_size           = var.AGS_MAX
  min_size           = var.AGS_MIN
  target_group_arns  = [aws_lb_target_group.target-grp.arn]


  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }

}

resource "aws_autoscaling_policy" "cpu-tracking-policy" {
  name        = "whenCPULoadIncrease"
  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }
  autoscaling_group_name = aws_autoscaling_group.auto_scale.name
}
