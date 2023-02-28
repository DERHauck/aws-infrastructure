resource "aws_vpc_endpoint" "this" {
  service_name            = "com.amazonaws.eu-central-1.s3"
  vpc_id                  = aws_vpc.this.id
  tags = {
    Name = var.name
  }
}

resource "aws_vpc_endpoint_route_table_association" "this" {
  route_table_id  = aws_vpc.this.main_route_table_id
  vpc_endpoint_id = aws_vpc_endpoint.this.id
}

resource "aws_internet_gateway" "this" {
}

resource "aws_internet_gateway_attachment" "this" {
  internet_gateway_id = aws_internet_gateway.this.id
  vpc_id              = aws_vpc.this.id
}

resource "aws_route" "igw" {
  route_table_id = aws_vpc.this.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.this.id
}