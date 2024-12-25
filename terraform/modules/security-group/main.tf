resource "aws_security_group" "sg" {
  vpc_id = var.vpc_id
  tags = {
    Name = "SecurityGroup"
  }
}

resource "aws_security_group_rule" "rules" {
  for_each = { for rule in var.security_group_rules : rule.from_port => rule }

  type        = "ingress"
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  protocol    = each.value.protocol
  cidr_blocks = each.value.cidr_blocks
  security_group_id = aws_security_group.sg.id
}

output "security_group_id" {
  value = aws_security_group.sg.id
}
