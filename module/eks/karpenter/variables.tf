variable "irsa_oidc_provider_arn" {
  type = string
  description = "EKS oidc provider arn"
}

variable "irsa_namespace_service_accounts" {
  type = list(string)
  description = "list of ISRA account for karpenter 'namespace:service_account_name'"
}

variable "cluster_name" {
  description = "Name of EKS cluster"
}

variable "irsa_tag_key" {
  description = "Tag key (`{key = value}`) applied to resources launched by Karpenter through the Karpenter provisioner"
  type        = string
  default     = "karpenter.sh/discovery"
}

variable "irsa_ssm_parameter_arns" {
  description = "List of SSM Parameter ARNs that contain AMI IDs launched by Karpenter"
  type        = list(string)
  # https://github.com/aws/karpenter/blob/ed9473a9863ca949b61b9846c8b9f33f35b86dbd/pkg/cloudprovider/aws/ami.go#L105-L123
  default = ["arn:aws:ssm:*:*:parameter/aws/service/*"]
}