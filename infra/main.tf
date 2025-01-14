terraform {
  required_version = "~> 1.10.4"

  backend "s3" {
    bucket = "dairyisscary-terraform-state"
    key    = "kimbutlerxyz/terraform.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.83.1"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.50.0"
    }
  }
}

locals {
  root_domain           = "kimbutler.xyz"
  cloudflare_account_id = "a135e34dcd53a22a339f6a334d0281db"
}

provider "aws" {
  region = "us-east-1"
}

provider "cloudflare" {
  api_token = trimspace(file(var.cloudflare_api_token_file))
}

variable "cloudflare_api_token_file" {
  type = string
}

resource "cloudflare_zone" "root" {
  account_id = local.cloudflare_account_id
  zone       = local.root_domain
}

module "grace" {
  source = "../domains/grace/infra"

  root_domain                = local.root_domain
  root_cloudflare_zone_id    = cloudflare_zone.root.id
  root_cloudflare_account_id = local.cloudflare_account_id
}

output "cloudflare_zone_id" {
  value = cloudflare_zone.root.id
}

output "grace_static_bucket_name" {
  value = module.grace.static_bucket_name
}
