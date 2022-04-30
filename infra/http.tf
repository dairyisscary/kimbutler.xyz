resource "cloudflare_zone_settings_override" "root_zone" {
  zone_id = cloudflare_zone.root.id

  settings {
    always_use_https         = "on"
    automatic_https_rewrites = "off"
    brotli                   = "on"
    browser_cache_ttl        = 0
    browser_check            = "off"
    http3                    = "on"
    ipv6                     = "on"
    min_tls_version          = "1.2"
    security_level           = "essentially_off"
    ssl                      = "flexible"
    tls_1_3                  = "zrt"
    websockets               = "off"
    zero_rtt                 = "on"
  }
}

resource "cloudflare_ruleset" "transform_http_headers" {
  zone_id     = cloudflare_zone.root.id
  name        = "Add Security HTTP Headers"
  description = "Add security headers to responses"
  kind        = "zone"
  phase       = "http_response_headers_transform"

  rules {
    enabled     = true
    description = "Add security headers to all HTML content-type responses"
    action      = "rewrite"
    expression  = "any(http.response.headers[\"content-type\"][*] contains \"text/html\")"

    action_parameters {
      # Keep these alphabetized by name so that terraform doesn't diff
      headers {
        operation = "set"
        name      = "Referrer-Policy"
        value     = "no-referrer-when-downgrade"
      }

      headers {
        operation = "set"
        name      = "X-Content-Type-Options"
        value     = "nosniff"
      }

      headers {
        operation = "set"
        name      = "X-Frame-Options"
        value     = "DENY"
      }

      headers {
        operation = "set"
        name      = "X-XSS-Protection"
        value     = "1; mode=block"
      }
    }
  }
}
