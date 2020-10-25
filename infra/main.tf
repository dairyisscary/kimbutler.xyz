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
  region = "us-east-1"
}

resource "aws_route53_zone" "root" {
  name = local.root_domain
}

module "grace" {
  source = "../domains/grace/infra"

  root_domain      = local.root_domain
  root_dns_zone_id = aws_route53_zone.root.zone_id
}

output "grace_static_bucket_name" {
  value = module.grace.static_bucket_name
}

output "grace_cdn_id" {
  value = module.grace.cdn_id
}
