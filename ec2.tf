resource "aws_instance" "public-servers" {
  count = var.env == "prod" ? 3 : 0
  #count = length(var.public_subnet_cidr)
  #ami = var.imagename
  ami                         = lookup(var.amis, var.region) # This is mapping#
  key_name                    = var.key_name
  instance_type               = var.instance_type
  subnet_id                   = element(aws_subnet.public-subnets.*.id, count.index)
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name    = "${var.vpc_name}-publicserver-${count.index + 1}"
    Env     = "prod"
    Owner   = "Me"
    Company = "DXC"
  }

  lifecycle {
    create_before_destroy = "true" #If there is changes in the user-data then you will re-deploy it, so if you wont add this one then first it will delete the server and then deleteit.if you add life cycle then after creation of new server then old one will get deleted.
    prevent_destroy       = "false"
    ignore_changes = [
      tags,
    ]
  }
}

resource "aws_instance" "private-servers" {
  count = var.env == "prod" ? 3 : 1
  #count = length(var.private_subnet_cidr)
  #ami = var.imagename
  ami                         = lookup(var.amis, var.region)
  key_name                    = var.key_name
  instance_type               = var.instance_type
  subnet_id                   = element(aws_subnet.private-subnets.*.id, count.index)
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = false
  tags = {
    Name    = "${var.vpc_name}-privateserver-${count.index + 1}"
    Env     = "prod"
    Owner   = "Me"
    Company = "DXC"
  }

  lifecycle {
    create_before_destroy = "true"
    prevent_destroy       = "false"
    ignore_changes = [
      tags,
    ]
  }

  depends_on = [aws_nat_gateway.myterraformvpc-natgw] #Private servers will get deployed only when nat-gw is ready#
}