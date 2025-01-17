locals {
  public_subdomain                      = "plux"
  host_matches_public_domain_expression = "(http.host eq \"${local.public_subdomain}.kimbutler.xyz\")"
}

resource "cloudflare_record" "theater_argo" {
  zone_id = cloudflare_zone.root.id
  type    = "CNAME"
  name    = local.public_subdomain
  content = "${cloudflare_zero_trust_tunnel_cloudflared.theater.id}.cfargotunnel.com"
  proxied = true
}

resource "cloudflare_zero_trust_tunnel_cloudflared" "theater" {
  account_id = cloudflare_zone.root.account_id
  name       = "Theater"
  config_src = "cloudflare"
  secret     = trimspace(file(var.cloudflare_theater_tunnel_password_file))
}

resource "cloudflare_zero_trust_tunnel_cloudflared_config" "theater" {
  account_id = cloudflare_zone.root.account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.theater.id

  config {
    ingress_rule {
      service  = "https://localhost:32400"
      hostname = "${local.public_subdomain}.${cloudflare_zone.root.zone}"

      origin_request {
        no_tls_verify = true
      }
    }
    ingress_rule {
      service = "http_status:404"
    }
  }
}

resource "cloudflare_ruleset" "public_plex_configuration_settings" {
  zone_id     = cloudflare_zone.root.id
  name        = "Public Plex Configuration Settings"
  description = "Configuration rules for the public Plex subdomain"
  phase       = "http_config_settings"
  kind        = "zone"

  rules {
    ref         = "set_config_settings"
    description = "When host matches Plex public subdomain, enable browser integrity check"
    expression  = local.host_matches_public_domain_expression
    action      = "set_config"
    action_parameters {
      bic = true
    }
  }
}

resource "cloudflare_ruleset" "public_plex_cache_settings" {
  zone_id     = cloudflare_zone.root.id
  name        = "Public Plex Cache Settings"
  description = "Cache rules for the public Plex subdomain"
  phase       = "http_request_cache_settings"
  kind        = "zone"

  rules {
    ref         = "cache_settings"
    description = "When host matches Plex public subdomain, skip the cache"
    expression  = local.host_matches_public_domain_expression
    action      = "set_cache_settings"
    action_parameters {
      cache = false
    }
  }
}

resource "cloudflare_ruleset" "public_plex_waf_settings" {
  zone_id     = cloudflare_zone.root.id
  name        = "Public Plex WAF Settings"
  description = "WAF rules for the public Plex subdomain"
  phase       = "http_request_firewall_custom"
  kind        = "zone"

  rules {
    ref         = "us_only_traffic"
    description = "When host matches Plex public subdomain and its \"risky\", block the request"
    expression = "${local.host_matches_public_domain_expression} and (${join(" or ", [
      "(ip.src.country ne \"US\")",
      "(cf.threat_score gt 40)",
      "(cf.client.bot)",
    ])})"
    action = "block"
  }
}

resource "cloudflare_notification_policy" "theater_tunnel_health" {
  account_id = cloudflare_zone.root.account_id
  name       = "Notifiy Tunnel Health Change"
  enabled    = true
  alert_type = "tunnel_health_event"

  email_integration {
    id = "eric@kimbutler.xyz"
  }
}
