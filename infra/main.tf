terraform {
  required_version = "~> 1.1.0"

  backend "s3" {
    bucket = "dairyisscary-terraform-state"
    key    = "kimbutlerxyz/terraform.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.11.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.13.0"
    }
  }
}

locals {
  root_domain = "kimbutler.xyz"
}

provider "aws" {
  region = "us-east-1"
}

provider "cloudflare" {}

resource "cloudflare_zone" "root" {
  zone = local.root_domain
}

module "grace" {
  source = "../domains/grace/infra"

  root_domain             = local.root_domain
  root_cloudflare_zone_id = cloudflare_zone.root.id
}

output "cloudflare_zone_id" {
  value = cloudflare_zone.root.id
}

output "grace_static_bucket_name" {
  value = module.grace.static_bucket_name
}
