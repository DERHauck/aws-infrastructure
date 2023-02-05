resource "aws_vpc_endpoint" "this" {
  service_name            = "com.amazonaws.eu-central-1.s3"
  vpc_id                  = aws_vpc.this.id
  tags = {
    Name = var.name
  }
}

resource "aws_vpc_endpoint_route_table_association" "this" {
  route_table_id  = aws_route_table.main.id
  vpc_endpoint_id = aws_vpc_endpoint.this.id
}