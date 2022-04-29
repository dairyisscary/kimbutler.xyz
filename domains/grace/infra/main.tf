terraform {
  required_version = "~> 1.1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.11.0"
    }
  }
}

variable "root_domain" {
  type = string
}

variable "root_dns_zone_id" {
  type = string
}

resource "aws_acm_certificate" "main_cert" {
  domain_name               = var.root_domain
  validation_method         = "DNS"
  subject_alternative_names = ["grace.${var.root_domain}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "main_cert" {
  certificate_arn         = aws_acm_certificate.main_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.main_cert_validation : record.fqdn]

  lifecycle {
    create_before_destroy = true
  }
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

resource "aws_cloudfront_distribution" "website_cdn" {
  enabled         = true
  is_ipv6_enabled = true
  price_class     = "PriceClass_All"
  http_version    = "http2"

  origin {
    origin_id   = "origin-bucket-${aws_s3_bucket.website_bucket.id}"
    domain_name = aws_s3_bucket.website_bucket.website_endpoint

    custom_origin_config {
      origin_protocol_policy = "http-only"
      http_port              = "80"
      https_port             = "443"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    min_ttl                = "0"
    default_ttl            = "86400"    # one day
    max_ttl                = "31536000" # one year
    target_origin_id       = "origin-bucket-${aws_s3_bucket.website_bucket.id}"
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    allowed_methods = [
      "GET",
      "HEAD",
    ]

    cached_methods = [
      "GET",
      "HEAD",
    ]

    forwarded_values {
      query_string = "false"

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate_validation.main_cert.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.1_2016"
  }

  aliases = [
    "grace.${var.root_domain}",
  ]
}

resource "aws_route53_record" "cdn_alias_a_domain" {
  zone_id = var.root_dns_zone_id
  name    = "grace.${var.root_domain}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.website_cdn.domain_name
    zone_id                = aws_cloudfront_distribution.website_cdn.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "cdn_alias_aaaa_domain" {
  zone_id = var.root_dns_zone_id
  name    = "grace.${var.root_domain}"
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.website_cdn.domain_name
    zone_id                = aws_cloudfront_distribution.website_cdn.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "main_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.main_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  zone_id = var.root_dns_zone_id
  ttl     = 60
}
