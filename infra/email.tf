resource "cloudflare_record" "hey_root_spam_protection" {
  zone_id = cloudflare_zone.root.id
  type    = "TXT"
  name    = "@"
  content = "v=spf1 include:_spf.hey.com ~all"
}

resource "cloudflare_record" "hey_dmarc_spam_protection" {
  zone_id = cloudflare_zone.root.id
  type    = "TXT"
  name    = "_dmarc"
  content = "v=DMARC1; p=none;"
}

resource "cloudflare_record" "hey_cname_email_auth" {
  zone_id = cloudflare_zone.root.id
  type    = "CNAME"
  name    = "heymail._domainkey"
  content = "heymail._domainkey.hey.com"
}

resource "cloudflare_record" "hey_mx_email" {
  zone_id  = cloudflare_zone.root.id
  type     = "MX"
  ttl      = 3600
  priority = 10
  name     = "@"
  content  = "work-mx.app.hey.com"
}

resource "cloudflare_record" "aws_ses_dkim_1" {
  zone_id = cloudflare_zone.root.id
  type    = "CNAME"
  name    = "z3i3pfmu2dtqouuammskg26x7dmtvwg2._domainkey.kimbutler.xyz"
  content = "z3i3pfmu2dtqouuammskg26x7dmtvwg2.dkim.amazonses.com"
}

resource "cloudflare_record" "aws_ses_dkim_2" {
  zone_id = cloudflare_zone.root.id
  type    = "CNAME"
  name    = "xcflhuf6od73o7exz4rr5dcnbfrkyeji._domainkey.kimbutler.xyz"
  content = "xcflhuf6od73o7exz4rr5dcnbfrkyeji.dkim.amazonses.com"
}

resource "cloudflare_record" "aws_ses_dkim_3" {
  zone_id = cloudflare_zone.root.id
  type    = "CNAME"
  name    = "c2kpj7rmffsop7u7pz5nmdprejc4nn6k._domainkey.kimbutler.xyz"
  content = "c2kpj7rmffsop7u7pz5nmdprejc4nn6k.dkim.amazonses.com"
}

resource "cloudflare_record" "aws_ses_home_dkim_1" {
  zone_id = cloudflare_zone.root.id
  type    = "CNAME"
  name    = "f45iq4empt6l4pbhsn3y7qsudbxm2wyn._domainkey.home.kimbutler.xyz"
  content = "f45iq4empt6l4pbhsn3y7qsudbxm2wyn.dkim.amazonses.com"
}

resource "cloudflare_record" "aws_ses_home_dkim_2" {
  zone_id = cloudflare_zone.root.id
  type    = "CNAME"
  name    = "2gmhp2fdzrhb7ykkxxb4gad46de22q6g._domainkey.home.kimbutler.xyz"
  content = "2gmhp2fdzrhb7ykkxxb4gad46de22q6g.dkim.amazonses.com"
}

resource "cloudflare_record" "aws_ses_home_dkim_3" {
  zone_id = cloudflare_zone.root.id
  type    = "CNAME"
  name    = "xhdln6bsdm5rcln5a5c5t3imn2znovbk._domainkey.home.kimbutler.xyz"
  content = "xhdln6bsdm5rcln5a5c5t3imn2znovbk.dkim.amazonses.com"
}
