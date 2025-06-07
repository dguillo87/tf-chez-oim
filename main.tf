terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

resource "cloudflare_dns_record" "mon_dns" {
  zone_id = "a3aa4938a1d46a31ecb34afc6a32af81"
  name    = "test"
  content = "192.0.2.1"
  type    = "A"
  ttl     = 3600
}

resource "cloudflare_dns_record" "mon_dns2" {
  zone_id = "a3aa4938a1d46a31ecb34afc6a32af81"
  name    = "test-tf"
  content = "192.0.2.1"
  type    = "A"
  ttl     = 3600
}

resource "cloudflare_dns_record" "test_dash" {
  zone_id = "a3aa4938a1d46a31ecb34afc6a32af81"
  name    = "test-dash"
  content = "192.0.2.1"
  type    = "A"
  ttl     = 3600
}

resource "cloudflare_firewall_rule" "wordpress" {
  zone_id = "a3aa4938a1d46a31ecb34afc6a32af81"
  action = {
    mode = "block"
    response = {
      body = "<error>This request has been blocked.</error>"
      content_type = "text/xml"
    }
    timeout = 86400
  }
  filter = {
    description = "Wordpress break-in attempts that are outside of the office"
    expression = "(http.request.uri.path ~ \".*wp-login.php\" or http.request.uri.path ~ \".*xmlrpc.php\") and ip.src ne 192.0.2.1"
    paused = false
    ref = "FIL-100"
  }
}
