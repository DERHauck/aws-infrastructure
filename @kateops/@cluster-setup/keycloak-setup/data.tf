data "keycloak_realm" "master" {
  realm = "master"
}

data "kubernetes_config_map" "env" {
  metadata {
    name = "keycloak-env-vars"
    namespace = "security"
  }
}