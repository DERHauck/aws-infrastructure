output "irsa_arn" {
  value = aws_iam_role.irsa.arn
}

output "instance_profile_arn" {
  description = "ARN assigned by AWS to the instance profile"
  value       = try(aws_iam_instance_profile.this.arn, null)
}

output "instance_profile_id" {
  description = "Instance profile's ID"
  value       = try(aws_iam_instance_profile.this.id, null)
}

output "instance_profile_name" {
  description = "Name of the instance profile"
  value       = try(aws_iam_instance_profile.this.name, null)
}

output "instance_profile_unique" {
  description = "Stable and unique string identifying the IAM instance profile"
  value       = try(aws_iam_instance_profile.this.unique_id, null)
}

output "role_name" {
  description = "The name of the IAM role"
  value       = try(aws_iam_role.this.name, null)
}

output "role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the IAM role"
  value       = aws_iam_role.this.arn
}

output "role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = try(aws_iam_role.this.unique_id, null)
}