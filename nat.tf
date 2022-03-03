resource "aws_eip" "eip-nat" {
  tags = {
    Name = "${var.vpc_name}NAT-EIP"
  }
}

resource "aws_nat_gateway" "myterraformvpc-natgw" {
  allocation_id = aws_eip.eip-nat.id
  subnet_id     = aws_subnet.public-subnets.0.id # This is implicit dependency#

  tags = {
    Name = "${var.vpc_name}gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.default]
}