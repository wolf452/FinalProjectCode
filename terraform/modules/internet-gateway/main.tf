resource "aws_internet_gateway" "igw" {
 
  vpc_id = var.vpc_id

  tags = {
    Name = "igw"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "rt"
  }
}
resource "aws_route_table_association" "rta" {
  for_each = tomap({
    for idx, subnet in var.subnets : idx => {
      cidr      = subnet.cidr
      subnet_id = subnet.subnet_id
    }
  })

  subnet_id      = each.value.subnet_id
  route_table_id = aws_route_table.rt.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

output "route_table_id" {
  value = aws_route_table.rt.id
}
