resource "aws_vpc" "this" {
  cidr_block = var.cidr
}

module "subnet" {
  source = "./modules/subnet/"  
}