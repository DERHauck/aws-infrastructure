
resource "aws_efs_access_point" "this" {
  posix_user {
    gid = 33
    uid = 33
  }
  root_directory {
    path = "/nextcloud"
    creation_info {
      owner_gid   = 33
      owner_uid   = 33
      permissions = "0755"
    }
  }
  file_system_id = var.efs_id
}

resource "kubernetes_persistent_volume_claim" "this" {
  metadata {
    name = "nextcloud-data-vc"
    namespace = var.namespace
  }
  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "3G"
      }
    }
    storage_class_name = "efs-sc"
    volume_name = kubernetes_persistent_volume.this.metadata[0].name
  }
  depends_on = [
    kubernetes_persistent_volume.this,
  ]
  lifecycle {
    replace_triggered_by = [
      kubernetes_persistent_volume.this
    ]
  }
}

resource "kubernetes_persistent_volume" "this" {
  metadata {
    name = "nextcloud-data"
  }
  spec {
    access_modes = ["ReadWriteMany"]
    capacity     = {
      storage = "3G"
    }
    persistent_volume_source {
      csi {
        driver        = "efs.csi.aws.com"
        volume_handle = "${aws_efs_access_point.this.file_system_id}::${aws_efs_access_point.this.id}"

      }
    }
    storage_class_name = "efs-sc"
  }
  depends_on = [
    aws_efs_access_point.this,
  ]
}