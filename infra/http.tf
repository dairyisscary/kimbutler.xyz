resource "cloudflare_zone_setting" "always_use_https" {
  zone_id    = cloudflare_zone.root.id
  setting_id = "always_use_https"
  value      = "on"
}

resource "cloudflare_zone_setting" "automatic_https_rewrites" {
  zone_id    = cloudflare_zone.root.id
  setting_id = "automatic_https_rewrites"
  value      = "off"
}

resource "cloudflare_zone_setting" "brotli" {
  zone_id    = cloudflare_zone.root.id
  setting_id = "brotli"
  value      = "on"
}

resource "cloudflare_zone_setting" "browser_cache_ttl" {
  zone_id    = cloudflare_zone.root.id
  setting_id = "browser_cache_ttl"
  value      = 0
}

resource "cloudflare_zone_setting" "browser_check" {
  zone_id    = cloudflare_zone.root.id
  setting_id = "browser_check"
  value      = "off"
}

resource "cloudflare_zone_setting" "http3" {
  zone_id    = cloudflare_zone.root.id
  setting_id = "http3"
  value      = "on"
}

resource "cloudflare_zone_setting" "ipv6" {
  zone_id    = cloudflare_zone.root.id
  setting_id = "ipv6"
  value      = "on"
}

resource "cloudflare_zone_setting" "min_tls_version" {
  zone_id    = cloudflare_zone.root.id
  setting_id = "min_tls_version"
  value      = "1.2"
}

resource "cloudflare_zone_setting" "security_level" {
  zone_id    = cloudflare_zone.root.id
  setting_id = "security_level"
  value      = "essentially_off"
}

resource "cloudflare_zone_setting" "ssl" {
  zone_id    = cloudflare_zone.root.id
  setting_id = "ssl"
  value      = "flexible"
}

resource "cloudflare_zone_setting" "tls_1_3" {
  zone_id    = cloudflare_zone.root.id
  setting_id = "tls_1_3"
  value      = "zrt"
}

resource "cloudflare_zone_setting" "websockets" {
  zone_id    = cloudflare_zone.root.id
  setting_id = "websockets"
  value      = "off"
}

resource "cloudflare_zone_setting" "zero_rtt" {
  zone_id    = cloudflare_zone.root.id
  setting_id = "0rtt"
  value      = "on"
}

resource "cloudflare_ruleset" "transform_http_headers" {
  zone_id     = cloudflare_zone.root.id
  name        = "Add Security HTTP Headers"
  description = "Add security headers to responses"
  kind        = "zone"
  phase       = "http_response_headers_transform"

  rules = [{
    enabled     = true
    description = "Add security headers to all HTML content-type responses"
    action      = "rewrite"
    expression  = "any(http.response.headers[\"content-type\"][*] contains \"text/html\")"

    action_parameters = {
      # Keep these alphabetized by name so that it doesn't diff
      headers = {
        "Referrer-Policy" = {
          operation = "set"
          value     = "no-referrer-when-downgrade"
        }
        "X-Content-Type-Options" = {
          operation = "set"
          value     = "nosniff"
        }
        "X-Frame-Options" = {
          operation = "set"
          value     = "DENY"
        }
        "X-XSS-Protection" = {
          operation = "set"
          value     = "1; mode=block"
        }
      }
    }
  }]
}
