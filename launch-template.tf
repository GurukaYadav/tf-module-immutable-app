resource "aws_launch_template" "template" {
  name = "auto-scaling-launch-template"

  iam_instance_profile {
    name = aws_iam_instance_profile.profile.name
  }

  image_id = data.aws_ami.ami.image_id

  instance_market_options {
    market_type = "spot"
  }

  instance_type = "t3.micro"

  Here we are given subnet ids instead of avaialability zones in which instances cana be launched by auto-scaling group
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
    resource_type = "spot_fleet_request"

    tags = {
      Name = local.TAG_NAME
    }
  }

#  user_data = filebase64("${path.module}/example.sh")
}