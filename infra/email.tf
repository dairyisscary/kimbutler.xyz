resource "cloudflare_dns_record" "proton_spf" {
  zone_id = cloudflare_zone.root.id
  type    = "TXT"
  name    = "@"
  content = "\"v=spf1 include:_spf.protonmail.ch ~all\""
  ttl     = 1
}

resource "cloudflare_dns_record" "proton_domain_verification" {
  zone_id = cloudflare_zone.root.id
  type    = "TXT"
  name    = "@"
  content = "\"protonmail-verification=4cd658d2f92447461ba677b6c46bd571bac5fd31\""
  ttl     = 1
}

resource "cloudflare_dns_record" "dmarc" {
  zone_id = cloudflare_zone.root.id
  type    = "TXT"
  name    = "_dmarc"
  content = "\"v=DMARC1; p=quarantine\""
  ttl     = 1
}

resource "cloudflare_dns_record" "proton_mx_1" {
  zone_id  = cloudflare_zone.root.id
  type     = "MX"
  priority = 10
  name     = "@"
  content  = "mail.protonmail.ch"
  ttl      = 1
}

resource "cloudflare_dns_record" "proton_mx_2" {
  zone_id  = cloudflare_zone.root.id
  type     = "MX"
  priority = 20
  name     = "@"
  content  = "mailsec.protonmail.ch"
  ttl      = 1
}

resource "cloudflare_dns_record" "proton_dkim_1" {
  zone_id = cloudflare_zone.root.id
  type    = "CNAME"
  name    = "protonmail._domainkey"
  content = "protonmail.domainkey.dr77dzstzp446wahdgh63nu5d5tkgjgtz2h3k4jmtkezns6fzsqga.domains.proton.ch"
  ttl     = 1
}

resource "cloudflare_dns_record" "proton_dkim_2" {
  zone_id = cloudflare_zone.root.id
  type    = "CNAME"
  name    = "protonmail2._domainkey"
  content = "protonmail2.domainkey.dr77dzstzp446wahdgh63nu5d5tkgjgtz2h3k4jmtkezns6fzsqga.domains.proton.ch"
  ttl     = 1
}

resource "cloudflare_dns_record" "proton_dkim_3" {
  zone_id = cloudflare_zone.root.id
  type    = "CNAME"
  name    = "protonmail3._domainkey"
  content = "protonmail3.domainkey.dr77dzstzp446wahdgh63nu5d5tkgjgtz2h3k4jmtkezns6fzsqga.domains.proton.ch"
  ttl     = 1
}

resource "cloudflare_dns_record" "aws_ses_dkim_1" {
  zone_id = cloudflare_zone.root.id
  type    = "CNAME"
  name    = "z3i3pfmu2dtqouuammskg26x7dmtvwg2._domainkey.kimbutler.xyz"
  content = "z3i3pfmu2dtqouuammskg26x7dmtvwg2.dkim.amazonses.com"
  ttl     = 1
}

resource "cloudflare_dns_record" "aws_ses_dkim_2" {
  zone_id = cloudflare_zone.root.id
  type    = "CNAME"
  name    = "xcflhuf6od73o7exz4rr5dcnbfrkyeji._domainkey.kimbutler.xyz"
  content = "xcflhuf6od73o7exz4rr5dcnbfrkyeji.dkim.amazonses.com"
  ttl     = 1
}

resource "cloudflare_dns_record" "aws_ses_dkim_3" {
  zone_id = cloudflare_zone.root.id
  type    = "CNAME"
  name    = "c2kpj7rmffsop7u7pz5nmdprejc4nn6k._domainkey.kimbutler.xyz"
  content = "c2kpj7rmffsop7u7pz5nmdprejc4nn6k.dkim.amazonses.com"
  ttl     = 1
}

resource "cloudflare_dns_record" "aws_ses_home_dkim_1" {
  zone_id = cloudflare_zone.root.id
  type    = "CNAME"
  name    = "f45iq4empt6l4pbhsn3y7qsudbxm2wyn._domainkey.home.kimbutler.xyz"
  content = "f45iq4empt6l4pbhsn3y7qsudbxm2wyn.dkim.amazonses.com"
  ttl     = 1
}

resource "cloudflare_dns_record" "aws_ses_home_dkim_2" {
  zone_id = cloudflare_zone.root.id
  type    = "CNAME"
  name    = "2gmhp2fdzrhb7ykkxxb4gad46de22q6g._domainkey.home.kimbutler.xyz"
  content = "2gmhp2fdzrhb7ykkxxb4gad46de22q6g.dkim.amazonses.com"
  ttl     = 1
}

resource "cloudflare_dns_record" "aws_ses_home_dkim_3" {
  zone_id = cloudflare_zone.root.id
  type    = "CNAME"
  name    = "xhdln6bsdm5rcln5a5c5t3imn2znovbk._domainkey.home.kimbutler.xyz"
  content = "xhdln6bsdm5rcln5a5c5t3imn2znovbk.dkim.amazonses.com"
  ttl     = 1
}
