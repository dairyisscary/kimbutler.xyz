resource "aws_route53_record" "hey_root_spam_protection" {
  zone_id = aws_route53_zone.root.zone_id
  name    = local.root_domain
  type    = "TXT"
  ttl     = "3600"
  records = ["v=spf1 include:_spf.hey.com ~all"]
}

resource "aws_route53_record" "hey_dmarc_spam_protection" {
  zone_id = aws_route53_zone.root.zone_id
  name    = "_dmarc.${local.root_domain}"
  type    = "TXT"
  ttl     = "3600"
  records = ["v=DMARC1; p=none;"]
}

resource "aws_route53_record" "hey_cname_email_auth" {
  zone_id = aws_route53_zone.root.zone_id
  name    = "heymail._domainkey.${local.root_domain}"
  type    = "CNAME"
  ttl     = "3600"
  records = ["heymail._domainkey.hey.com."]
}

resource "aws_route53_record" "hey_mx_email" {
  zone_id = aws_route53_zone.root.zone_id
  name    = local.root_domain
  type    = "MX"
  ttl     = "3600"
  records = ["10 work-mx.app.hey.com"]
}
