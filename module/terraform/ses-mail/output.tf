output "username" {
  value = aws_iam_access_key.this.id
}

output "password" {
  value = aws_iam_access_key.this.ses_smtp_password_v4
}

output "host" {
  value = "email-smtp.eu-central-1.amazonaws.com"
}

