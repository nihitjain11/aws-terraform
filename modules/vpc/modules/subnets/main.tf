resource "aws_subnet" "public" {
  vpc_id                          = aws_vpc.this.vpc_id
  cidr_block                      = element(concat(var.public_subnets, [""]), count.index)
  availability_zone               = element(var.azs, count.index)
  map_public_ip_on_launch         = var.map_public_ip_on_launch
}

resource "aws_subnet" "private" {
  vpc_id                          = aws_vpc.this.vpc_id
  cidr_block                      = var.private_subnets[count.index]
  availability_zone               = element(var.azs, count.index)
}