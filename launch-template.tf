resource "aws_launch_template" "template" {
  name_prefix = "auto-scaling-launch-template"

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = local.TAG_NAME
    }
  }


  iam_instance_profile {
    name = aws_iam_instance_profile.profile.name
  }

  image_id = data.aws_ami.ami.image_id

  instance_market_options {
    market_type = "spot"
  }

  instance_type = var.INSTANCE_TYPE

#  Here we are given subnet ids instead of availability zones in which instances can be launched by auto-scaling group
#  placement {
#    availability_zone = "us-west-2a"
#  }

  vpc_security_group_ids = [aws_security_group.sg.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = local.TAG_NAME
    }
  }

  tag_specifications {
    resource_type = "spot-instances-request"

    tags = {
      Name = local.TAG_NAME
    }
  }

#  user_data = filebase64("${path.module}/example.sh")
}