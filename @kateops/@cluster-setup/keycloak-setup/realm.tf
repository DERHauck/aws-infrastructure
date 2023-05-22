resource "keycloak_realm" "master" {
  realm = "master"
  enabled = true
  display_name = "Kateops"
  display_name_html = "<div class=\"kc-logo-text\"><span>Kateops</span></div>"
  login_theme = "base"
  access_code_lifespan = "1m0s"
  ssl_required = "external"
  default_signature_algorithm = "RS256"
  smtp_server {
    from = "keycloak@kateops.com"
    from_display_name = "Kateops Keycloak"
    ssl = true
    host = module.ses.host
    auth {
      password = module.ses.password
      username = module.ses.username
    }
  }

}