resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc-id
}
resource "aws_eip" "eip" {
  vpc = true
}
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = var.pub_subnets[0].id
}
module "myroutes" {
  source = "./../routes/"
  vpc-id = var.vpc-id
  nat_id = aws_nat_gateway.nat.id
  igw_id = aws_internet_gateway.igw.id
  priv_subnets = var.priv_subnets
  pub_subnets = var.pub_subnets
}
