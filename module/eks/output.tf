output "cluster_oidc_issuer_url" {
  value = module.eks.cluster_oidc_issuer_url
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}

output "node_security_group_id" {
  value = module.eks.node_security_group_id
}

output "node_role_name" {
  value = module.eks.cluster_iam_role_name
}

output "oidc_issuer" {
  value = local.eks_oidc_issuer
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "oidc_issuer_arn" {
  value = module.eks.oidc_provider_arn
}