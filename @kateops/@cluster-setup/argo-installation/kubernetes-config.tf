resource "kubernetes_config_map" "cm" {
  metadata {
    name = "argocd-cm"
    namespace = var.namespace
    labels = {
      "app.kubernetes.io/name" = "argocd-cm"
      "app.kubernetes.io/part-of" = "argocd"
      "app.kubernetes.io/component" = "server"
      "app.kubernetes.io/managed-by" = "terraform"
      "app.kubernetes.io/instance" = "argo"
    }
  }
  data = {
    "admin.enabled" = false
    "application.instanceLabelKey" = "argocd.argoproj.io/instance"
    "application.resourceTrackingMethod": "annotation+label"
    "exec.enabled" = false
    "server.rbac.log.enforce.enable" = false
    "timeout.hard.reconciliation" = "0s"
    "timeout.reconciliation" = "180s"
    "url" = "https://${var.argo_host_name}"
    "oidc.config" = <<EOF
      name: Keycloak
      issuer: https://sso.kateops.com/realms/master
      clientID: ${data.vault_generic_secret.oidc.data["id"]}
      clientSecret: $oidc.keycloak.clientSecret
      requestedScopes: ["openid", "profile", "email", "roles"]

EOF
  }

}