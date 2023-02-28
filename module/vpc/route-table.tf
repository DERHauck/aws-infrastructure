resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
}


resource "aws_route_table_association" "private" {
  route_table_id = aws_route_table.private.id
  subnet_id = aws_subnet.private.id
}

resource "aws_route_table_association" "test" {
  route_table_id = aws_route_table.private.id
  subnet_id = aws_subnet.test.id
}

resource "aws_route_table_association" "database" {
  route_table_id = aws_route_table.private.id
  subnet_id = aws_subnet.database.id
}