resource "aws_vpc" "vpc" {
    cidr_block = var.cidr
}

module "mysubnet" {
  source = "./modules/subnets/"
  
  private_subnets = var.priv_cidr
  public_subnets = var.pub_cidr
  azs = var.azs
  vpc-id = aws_vpc.vpc.id
}