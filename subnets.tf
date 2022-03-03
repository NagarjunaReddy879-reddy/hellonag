resource "aws_subnet" "public-subnets" {
  count             = length(var.public_subnet_cidr)
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(var.public_subnet_cidr, count.index) #So here element is the function and syn element(list, count)#
  availability_zone = element(lookup(var.azs, var.region), count.index)

  tags = {
    Name = "${var.vpc_name}-publicsubnet-${count.index + 1}" # which means vpcname-Subnet0-3#
  }
}

resource "aws_subnet" "private-subnets" {
  count             = length(var.private_subnet_cidr)
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(var.private_subnet_cidr, count.index) #So here element is the function and syn element(list, count)#
  availability_zone = element(lookup(var.azs, var.region), count.index)

  tags = {
    Name = "${var.vpc_name}-privatesubnet-${count.index + 1}" # which means vpcname-Subnet0-3#
  }
}