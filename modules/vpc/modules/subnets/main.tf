resource "aws_subnet" "private" {
  count = length(var.private_subnets)
  vpc_id            = var.vpc-id
  cidr_block        = element(var.private_subnets,count.index)
  availability_zone = element(var.azs,count.index)
}
resource "aws_subnet" "public" {
  count = length(var.public_subnets)
  vpc_id            = var.vpc-id
  cidr_block        = element(var.public_subnets,count.index)
  availability_zone = element(var.azs,count.index)
}
module "mygateways" {
  source = "./../gateways/"
  vpc-id = var.vpc-id
  priv_subnets = aws_subnet.private
  pub_subnets = aws_subnet.public
}
