terraform {
  required_version = "~> 1.10.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.19.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.15.0"
    }
  }
}

variable "root_domain" {
  type = string
}

variable "root_cloudflare_zone_id" {
  type = string
}

variable "root_cloudflare_account_id" {
  type = string
}

resource "aws_s3_bucket_policy" "website_bucket_policy" {
  bucket = aws_s3_bucket.website_bucket.id
  policy = data.aws_iam_policy_document.website_bucket_policy_document.json
}

data "aws_iam_policy_document" "website_bucket_policy_document" {
  statement {
    sid       = "PublicReadAccess"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.website_bucket.bucket}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_website_configuration" "website_bucket_website" {
  bucket = aws_s3_bucket.website_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}

resource "aws_s3_bucket_versioning" "website_bucket_versioning" {
  bucket = aws_s3_bucket.website_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "website_bucket_lifecycle" {
  bucket = aws_s3_bucket.website_bucket.id

  rule {
    id     = "DeleteOldVersions"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 14
    }
  }
}

resource "aws_s3_bucket" "website_bucket" {
  bucket = "grace.${var.root_domain}"

  lifecycle {
    prevent_destroy = true
  }
}

output "static_bucket_name" {
  value = aws_s3_bucket.website_bucket.bucket
}

resource "cloudflare_record" "grace" {
  zone_id = var.root_cloudflare_zone_id
  type    = "CNAME"
  name    = "grace"
  value   = aws_s3_bucket_website_configuration.website_bucket_website.website_endpoint
  proxied = true
}

resource "cloudflare_worker_script" "api" {
  account_id = var.root_cloudflare_account_id
  name       = "api"
  content    = file("${path.module}/../src/api/v1.mjs")
}

resource "cloudflare_worker_route" "api" {
  zone_id     = var.root_cloudflare_zone_id
  pattern     = "grace.${var.root_domain}/api/v1/*"
  script_name = cloudflare_worker_script.api.name
}
