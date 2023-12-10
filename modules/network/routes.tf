
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

resource "aws_route_table" "private_route" {
  for_each = aws_nat_gateway.nat_gw
  
  vpc_id = aws_vpc.main.id

  depends_on    = [aws_nat_gateway.nat_gw]

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw[each.key].id
  }

  tags = {
    Name = "${var.project_name}-route-nat-${local.nat_gw_subnet_names[each.value.subnet_id]}"
  }
}

## Map each private subnet to the
## NAT gateway that is present in the public subnet
## from the same Av. Zone. 
## For example:
##  Av.zone us-east-1a contains 1 subnet public and 1 private.
##  Instances placed on the private subnet will connect to 
##  the internet using the NAT gateway present on the public 
##  subnet available at us-east-1a
resource "aws_route_table_association" "priv_sub_route" {
  for_each = var.private_subnets

  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private_route[local.nat_gateway_az_map[each.value.av_zone]].id
}

locals {
  nat_gateway_az_map = { for subnet_key, subnet in var.public_subnets : subnet.av_zone => subnet_key }
  nat_gw_subnet_names = { for key, subnet in aws_subnet.public : subnet.id => key }
}
