provider "aws" {
    region = "us-east-1"
    version = "~> v2.0"
}
resource "aws_vpc" "vpc" {
    cidr_block      = "10.0.0.0/16"
}

resource "aws_subnet" "private1" {
  vpc_id                          = "${aws_vpc.vpc.id}"
  cidr_block                      = "10.0.1.0/24"
  availability_zone               = "us-east-1a"
}
resource "aws_subnet" "private2" {
  vpc_id                          = "${aws_vpc.vpc.id}"
  cidr_block                      = "10.0.2.0/24"
  availability_zone               = "us-east-1a"
}
resource "aws_subnet" "public1" {
  vpc_id                          = "${aws_vpc.vpc.id}"
  cidr_block                      = "10.0.3.0/24"
  availability_zone               = "us-east-1a"
  depends_on = ["aws_internet_gateway.igw"]
}
resource "aws_subnet" "public2" {
  vpc_id                          = "${aws_vpc.vpc.id}"
  cidr_block                      = "10.0.4.0/24"
  availability_zone               = "us-east-1a"
  depends_on = ["aws_internet_gateway.igw"]
}
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
}
resource "aws_eip" "eip" {
  vpc = true
}
resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.eip.id}"
  subnet_id     = "${aws_subnet.public1.id}"
}
resource "aws_route_table" "rt_priv" {
  vpc_id = "${aws_vpc.vpc.id}"
}
resource "aws_route_table" "rt_pub" {
  vpc_id = "${aws_vpc.vpc.id}"   
}
resource "aws_route" "r_priv" {
  route_table_id            = "${aws_route_table.rt_priv.id}"
  nat_gateway_id            = "${aws_nat_gateway.nat.id}"
  destination_cidr_block    = "0.0.0.0/0"
}

resource "aws_route" "r_pub" {
  route_table_id            = "${aws_route_table.rt_pub.id}"
  nat_gateway_id            = "${aws_internet_gateway.igw.id}"
  destination_cidr_block    = "0.0.0.0/0"
}
resource "aws_route_table_association" "rta_priv" {
  subnet_id      = "${aws_subnet.private1.id}"
  route_table_id = "${aws_route_table.rt_priv.id}"
}
resource "aws_route_table_association" "rta_pub1" {
  subnet_id      = "${aws_subnet.public1.id}"
  route_table_id = "${aws_route_table.rt_pub.id}"
}
resource "aws_route_table_association" "rta_pub2" {
  subnet_id      = "${aws_subnet.public2.id}"
  route_table_id = "${aws_route_table.rt_pub.id}"
}