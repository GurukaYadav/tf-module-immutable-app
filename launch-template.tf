resource "aws_launch_template" "template" {
  name = "${local.TAG_NAME}-lt"

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

  user_data = base64encode(templatefile("${path.module}/userdata.sh", {
    ENV                    = var.ENV
    COMPONENT              = var.COMPONENT
    DOCDB_ENDPOINT         = var.DOCDB_ENDPOINT
    DOCDB_USER             = jsondecode(data.aws_secretsmanager_secret_version.secret.secret_string)["DOCDB_USER"]
    DOCDB_PASS             = jsondecode(data.aws_secretsmanager_secret_version.secret.secret_string)["DOCDB_PASS"]
    RABBITMQ_USER_PASSWORD = jsondecode(data.aws_secretsmanager_secret_version.secret.secret_string)["RABBITMQ_USER_PASSWORD"]
    RDS_ENDPOINT           = var.RDS_ENDPOINT
    REDIS_ENDPOINT         = var.REDIS_ENDPOINT

  }))
}