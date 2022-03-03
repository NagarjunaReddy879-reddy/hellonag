region     = "ap-northeast-1"
profile    = "default"
vpc_name   = "myterraformvpc"
cidr_block = "10.0.0.0/16"
#azs                 = [ "us-east-2a", "us-east-2b", "us-east-2c" ]
public_subnet_cidr  = ["10.0.1.0/24", "10.0.2.0/24"] # This will act as list#
private_subnet_cidr = ["10.0.7.0/24", "10.0.8.0/24"]
imagename           = "ami-0fb653ca2d3203ac1"
instance_type       = "t2.nano"
key_name            = "nag-tokyo"
amis = { # This will act as mapping#
  "us-east-2"      = "ami-0fb653ca2d3203ac1",
  "ap-northeast-1" = "ami-088da9557aae42f39",
}

azs = {
  "us-east-2"      = ["us-east-2a", "us-east-2b", "us-east-2c"]
  "ap-northeast-1" = ["ap-northeast-1a", "ap-northeast-1d", "ap-northeast-1c"]
}
env = "prod"