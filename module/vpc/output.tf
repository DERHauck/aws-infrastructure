output "vpc_id" {
  value = aws_vpc.this.id
}

output "subnets" {
  value = {
    "private" = aws_subnet.private
    "database" = aws_subnet.database
    "test" = aws_subnet.test
    "public" = aws_subnet.public
  }
  depends_on = [
    aws_internet_gateway.this,
    aws_internet_gateway_attachment.this,
    aws_instance.nat,
    aws_vpc_endpoint.this,
  ]
}