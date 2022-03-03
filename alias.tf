resource "aws_vpc" "default-tokyo" {
  provider             = aws.tokyo
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "default-tokyo" {
  provider = aws.tokyo
  vpc_id   = aws_vpc.default-tokyo.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

resource "aws_subnet" "public-subnets-tokyo" {
  provider          = aws.tokyo
  count             = length(var.public_subnet_cidr)
  vpc_id            = aws_vpc.default-tokyo.id
  cidr_block        = element(var.public_subnet_cidr, count.index) #So here element is the function and syn element(list, count)#
  availability_zone = element(lookup(var.azs, "ap-northeast-1"), count.index)

  tags = {
    Name = "${var.vpc_name}-publicsubnet-${count.index + 1}" # which means vpcname-Subnet0-3#
  }
}

resource "aws_subnet" "private-subnets-tokyo" {
  provider          = aws.tokyo
  count             = length(var.private_subnet_cidr)
  vpc_id            = aws_vpc.default-tokyo.id
  cidr_block        = element(var.private_subnet_cidr, count.index) #So here element is the function and syn element(list, count)#
  availability_zone = element(lookup(var.azs, "ap-northeast-1"), count.index)

  tags = {
    Name = "${var.vpc_name}-privatesubnet-${count.index + 1}" # which means vpcname-Subnet0-3#
  }
}