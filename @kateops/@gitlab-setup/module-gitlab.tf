module "gitlab" {
  source = "./gitlab-setup"
  vault_root_token = var.vault_root_token
  namespace   = data.vault_generic_secret.gitlab_runner.data["namespace"]
  kubeconfig = module.ns-deployment_service_account.kubeconfig
}


module "gitlab_runner" {
  for_each = local.gitlab_runners
  source = "./gitlab-runner-installation"
  access_key = data.vault_generic_secret.gitlab_runner.data["access_key"]
  secret_key = data.vault_generic_secret.gitlab_runner.data["secret_key"]
  concurrency = 100
  namespace   = data.vault_generic_secret.gitlab_runner.data["namespace"]
  pressure = each.key
  registration_token = data.vault_generic_secret.gitlab_runner.data["registration_token"]
  s3_cache_bucket_name = data.vault_generic_secret.gitlab_runner.data["s3_cache_bucket_name"]
  s3_default_host = "s3.amazonaws.com"
  image_pull_secret = module.gitlab.image_pull_secret
  cpu_limit = each.value["cpu_limit"]
  memory_limit = each.value["memory_limit"]
  service_memory_limit = try(each.value["service_memory_limit"], null)
  helper_memory_limit = try(each.value["helper_memory_limit"], null)
  anti_affinity = try(each.value["anti_affinity"], null)
}

locals {
  gitlab_runners = {
    medium = {
      cpu_limit = "500m"
      memory_limit = "2Gi"
    }
    high = {
      cpu_limit = "1000m"
      memory_limit = "4Gi"
    }
    buildkit = {
      cpu_limit = "1000m"
      memory_limit = "4Gi"
      anti_affinity = {
        topology_key = "kubernetes.io/hostname"
        key = "type/gitlab-runner"
        operator = "In"
        values = ["buildkit"]
      }
    }
  }
}