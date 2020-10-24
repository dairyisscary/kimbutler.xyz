terraform {
  backend "s3" {
    bucket = "dairyisscary-terraform-state"
    key    = "kimbutlerxyz/terraform.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      version = "~> 3.12"
    }
  }
}

locals {
  root_domain = "kimbutler.xyz"
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_route53_zone" "root" {
  name = local.root_domain
}
