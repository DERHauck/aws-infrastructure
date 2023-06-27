resource "kubernetes_deployment" "buildkit" {
  metadata {
    labels = local.labels
    name = local.app
    namespace = local.namespace
  }
  spec {
    replicas = "1"
    selector {
      match_labels = local.labels
    }
    template {
      metadata {
        labels = local.labels
        annotations = {
          "container.apparmor.security.beta.kubernetes.io/buildkitd" = "unconfined"
        }
      }
      spec {
        container {
          resources {
            limits = {
              cpu = "3000m"
              memory = "5G"
            }
            requests = {
              cpu = "300m"
              memory = "3.5G"
            }
          }
          name = local.app
          image = "moby/buildkit:master-rootless"
          image_pull_policy = "Always"
          args = [
            "--addr",
            "unix:///run/user/1000/buildkit/buildkitd.sock",
            "--addr",
            "tcp://0.0.0.0:1234",
            "--oci-worker-no-process-sandbox",
          ]
          readiness_probe {
            exec {
              command = [
                "buildctl",
                "debug",
                "workers"
              ]
            }
            initial_delay_seconds = 10
            period_seconds = 5
          }
          liveness_probe {
            exec {
              command = [
                "buildctl",
                "debug",
                "workers"
              ]
            }
            initial_delay_seconds = 5
            period_seconds = 30
          }
          security_context {
            seccomp_profile {
              type = "Unconfined"
            }
            privileged = false
            run_as_group = "1000"
            run_as_user = "1000"
          }
          port {
            container_port = 1234
          }
          volume_mount {
            mount_path = "/etc/buildkit"
            name       = local.app
          }
          volume_mount {
            mount_path = "/home/user/.config/buildkit"
            name = "buildkit-config"
          }
        }
        volume {
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim_v1.buildkit.metadata[0].name
          }
          name = local.app
        }
        volume {
          config_map {
            name = kubernetes_config_map.buildkit.metadata[0].name
          }
          name = "buildkit-config"
        }
      }
    }
  }
}

resource "kubernetes_config_map" "buildkit" {
  metadata {
    name = local.app
    namespace = local.namespace
  }
  data = {
    "buildkitd.toml" = file("${path.module}/buildkit.toml")
  }
}


resource "kubernetes_persistent_volume_claim_v1" "buildkit" {
  metadata {
    namespace = local.namespace
    name = "${local.app}-vc"
  }
  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "10Gi"
      }
    }
    storage_class_name = "efs-sc"
  }
}

resource "kubernetes_service" "buildkit" {
  metadata {
    labels = local.labels
    namespace = local.namespace
    name = "${local.app}-svc"
  }
  spec {
    port {
      port = 1234
      protocol = "TCP"
    }
    selector = local.labels
  }
}
