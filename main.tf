terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

resource "cloudflare_record" "mon_dns" {
  zone_id = "a3aa4938a1d46a31ecb34afc6a32af81"
  name    = "test"
  content = "192.0.2.1"
  type    = "A"
  ttl     = 3600
}

resource "cloudflare_record" "mon_dns2" {
  zone_id = "a3aa4938a1d46a31ecb34afc6a32af81"
  name    = "test-tf"
  content = "192.0.2.1"
  type    = "A"
  ttl     = 3600
}

resource "cloudflare_record" "test_dash" {
  zone_id = "a3aa4938a1d46a31ecb34afc6a32af81"
  name    = "test-dash"
  content = "192.0.2.1"
  type    = "A"
  ttl     = 3600
}

resource "cloudflare_record" "test_git" {
  zone_id = "a3aa4938a1d46a31ecb34afc6a32af81"
  name    = "test-git"
  content = "192.0.2.1"
  type    = "A"
  ttl     = 3600
}

