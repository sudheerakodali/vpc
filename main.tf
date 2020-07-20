provider "aws" {
region = "us-east-1"
}
//for creating vpc

resource "aws_vpc" "test-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "test-vpc"
}

//for creating subnets

resource "aws_subnet" "test-sub" {
  count = length(var.subnets)
  vpc_id     = aws_vpc.test-vpc.id
  cidr_block = var.cidr_range
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = subnet[count.index]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

//for creating internet gateway

resource "aws_internet_gateway" "test-gw" {
  vpc_id = aws_vpc.test-vpc.id

  tags = {
    Name = "test-gw"
  }
}

//for creating route table

resource "aws_route_table" "test-rt" {
    vpc_id = aws_vpc.test-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test-gw.id
  }
   tags = {
    Name = "public-rt"
  }
}

//for creating route table assosiation

resource "aws_route_table_association" "test-a" {
  count = length(var.subnets)
  subnet_id      = aws_subnet.test-sub[count.index].id
  route_table_id = aws_route_table.test-rt.id
}