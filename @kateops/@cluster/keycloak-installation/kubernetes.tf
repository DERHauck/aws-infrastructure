resource "kubernetes_secret" "keycloak" {
  metadata {
    name      = "keycloak"
    namespace = "security"
    labels    = {
      "app.kubernetes.io/component" : "keycloak"
      "app.kubernetes.io/instance" : "keycloak"
      "app.kubernetes.io/name" : "keycloak"
    }
  }
  data = {
    admin-password : random_password.keycloak_admin_password.result
    management-password : random_password.keycloak_management_password.result
    password : var.rdbs.password
  }
}
