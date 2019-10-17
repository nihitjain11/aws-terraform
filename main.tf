provider "aws" {
    region = "us-east-1"
    version = "~> v2.0"
}
resource "aws_vpc" "vpc" {
    cidr_block      = "10.0.0.0/16"
}

resource "aws_subnet" "private" {
  vpc_id                          = "${aws_vpc.vpc.id}"
  cidr_block                      = "10.0.1.0/24"
  availability_zone               = "us-east-1a"
}

resource "aws_subnet" "public" {
  vpc_id                          = "${aws_vpc.vpc.id}"
  cidr_block                      = "10.0.3.0/24"
  availability_zone               = "us-east-1a"
  
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route_table" "rt" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "10.0.1.0/24"
  }

  route {
    cidr_block = "10.0.3.0/24"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }    
}
