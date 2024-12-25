resource "aws_iam_role" "cloudwatch_role" {
  name = "ec2_cloudwatch_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cloudwatch_policy" {
  role       = aws_iam_role.cloudwatch_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_cloudwatch_instance_profile"
  role = aws_iam_role.cloudwatch_role.name
}

resource "aws_instance" "ec2" {
  ami               = var.ami_id
  instance_type     = var.instance_type
  subnet_id         = var.subnet_id
  security_groups   = [var.security_group_id]
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  monitoring        = true
  tags              = var.tags
  key_name          = var.key_name

  user_data = <<-EOT
    #!/bin/bash
    yum install -y amazon-cloudwatch-agent
    /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
      -a fetch-config \
      -m ec2 \
      -c ssm:${var.cloudwatch_config_ssm_key} \
      -s
  EOT

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = false
    ignore_changes        = [tags]
  }
}

output "instance_id" {
  value = aws_instance.ec2.id
}
output "ec2_public_ips" {
    value = aws_instance.ec2.*.public_ip
}
