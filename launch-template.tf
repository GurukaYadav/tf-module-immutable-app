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

  placement {
    availability_zone = "us-west-2a"
  }

  vpc_security_group_ids = ["sg-12345678"]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test"
    }
  }

#  user_data = filebase64("${path.module}/example.sh")
}