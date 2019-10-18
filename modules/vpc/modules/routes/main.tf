resource "aws_route_table" "rt_priv" {
  vpc_id = var.vpc-id
}

resource "aws_route_table" "rt_pub" {
  vpc_id = var.vpc-id   
}

resource "aws_route" "r_priv" {
  route_table_id            = aws_route_table.rt_priv.id
  nat_gateway_id            = var.nat_id
  destination_cidr_block    = "0.0.0.0/0"
}

resource "aws_route" "r_pub" {
  route_table_id            = aws_route_table.rt_pub.id
  gateway_id                = var.igw_id
  destination_cidr_block    = "0.0.0.0/0"
}

resource "aws_route_table_association" "rta_pub" {
  count = length(var.pub_subnets)
  subnet_id      = element(var.pub_subnets.*.id,count.index)
  route_table_id = aws_route_table.rt_pub.id
}

resource "aws_route_table_association" "rta_priv" {
  # count = length(var.priv_subnets) # enable this to associate other private subnets with nat_gw
  subnet_id      = var.priv_subnets[0].id
  route_table_id = aws_route_table.rt_priv.id
}