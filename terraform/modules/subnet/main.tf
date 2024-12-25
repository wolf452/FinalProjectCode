resource "aws_subnet" "subnet" {
  for_each = { for subnet in var.subnets : subnet.cidr => subnet }

  vpc_id                  = var.vpc_id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch

  tags = {
    Name = "Subnet-${each.key}"
  }
}




output "public_subnet_ids" {
  value = [for s in aws_subnet.subnet : s.id]
}