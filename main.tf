#This Terraform code deploys Basic vpc infra
provider "aws" {
  region  = var.region
  profile = var.profile
}

provider "aws" {
  region = "ap-northeast-1"
  alias  = "tokyo"
}

terraform {
  required_version = "<= 1.1.2" #Forcing which version of terraform needs to be used
  required_providers {
    aws = {
      version = "<= 3.7.0" # Forcing which version of plugin needs to be used.
      source  = "hashicorp/aws"
    }
  }
}