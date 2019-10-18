resource "aws_subnet" "private" {
  count = length(var.private_subnets)
  vpc_id                          = var.vpc-id
  cidr_block                      = element(var.private_subnets,count.index)
  availability_zone               = element(var.azs,count.index)
}