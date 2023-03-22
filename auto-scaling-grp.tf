resource "aws_autoscaling_group" "auto_scale" {
  vpc_zone_identifier = var.PRIVATE_SUBNET_ID
  desired_capacity   = var.AGS_DESIRED
  max_size           = var.AGS_MAX
  min_size           = var.AGS_MIN
  target_group_arns  = [aws_lb_target_group.target-grp.arn]

  tag {
    key                 = "Name"
    value               = "${local.TAG_NAME}-asg"
    propagate_at_launch = true
  }

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }


}