resource "aws_route53_record" "fathom_analytics_cname" {
  zone_id = aws_route53_zone.root.zone_id
  name    = "quiet-nine.${local.root_domain}"
  type    = "CNAME"
  ttl     = 600
  records = ["thorn-side-kings-leon.b-cdn.net"]
}
