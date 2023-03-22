resource "aws_autoscaling_group" "auto_scale" {
  vpc_zone_identifier = var.PRIVATE_SUBNET_ID
  desired_capacity   = var.AGS_DESIRED
  max_size           = var.AGS_MAX
  min_size           = var.AGS_MIN

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }
}