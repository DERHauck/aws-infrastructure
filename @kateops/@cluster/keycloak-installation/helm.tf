resource "helm_release" "keycloak" {
  name      = "keycloak"
  namespace = "security"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "keycloak"
  values     = local.templates
}
