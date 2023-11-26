
resource "aws_route_table" "public_route" {
  vpc_id       = aws_vpc.main.id
  depends_on   = [aws_internet_gateway.gateway]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = "${var.project_name}-public-route"
  }
}

resource "aws_route_table_association" "pub_sub_route" {
  for_each       = var.public_subnets
  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public_route.id
}


