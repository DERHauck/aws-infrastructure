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
}