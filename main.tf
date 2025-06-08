terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4"
    }
  }

    backend "s3" {
    bucket     = "terraform-state-david-cloudflare"
    region     = "eu-west-3"
    key        = "env:terraform.tfstate"
    encrypt        = true
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

resource "cloudflare_filter" "wordpress" {
  zone_id  = "a3aa4938a1d46a31ecb34afc6a32af81"
  expression = "(http.request.uri.path contains \"/wp-login.php\")"
  description = "Block wp-login.php"
}

resource "cloudflare_firewall_rule" "block_wp_login" {
  zone_id     = "a3aa4938a1d46a31ecb34afc6a32af81"
  filter_id   = cloudflare_filter.wordpress.id
  action      = "block"
  description = "Block access to wp-login.php"
}

