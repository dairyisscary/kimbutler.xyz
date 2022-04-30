resource "cloudflare_record" "hey_root_spam_protection" {
  zone_id = cloudflare_zone.root.id
  type    = "TXT"
  name    = "@"
  value   = "v=spf1 include:_spf.hey.com ~all"
}

resource "cloudflare_record" "hey_dmarc_spam_protection" {
  zone_id = cloudflare_zone.root.id
  type    = "TXT"
  name    = "_dmarc"
  value   = "v=DMARC1; p=none;"
}

resource "cloudflare_record" "hey_cname_email_auth" {
  zone_id = cloudflare_zone.root.id
  type    = "CNAME"
  name    = "heymail._domainkey"
  value   = "heymail._domainkey.hey.com"
}

resource "cloudflare_record" "hey_mx_email" {
  zone_id  = cloudflare_zone.root.id
  type     = "MX"
  ttl      = 3600
  priority = 10
  name     = "@"
  value    = "work-mx.app.hey.com"
}
