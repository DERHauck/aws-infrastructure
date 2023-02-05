locals {
  subnet_list = cidrsubnets("10.1.0.0/16",1, 2, 3, 3)
}


resource "aws_subnet" "main" {
  vpc_id = aws_vpc.this.id
  cidr_block = local.subnet_list[0]
  tags = {
    Name = "${var.name}-Main"
  }
}

resource "aws_subnet" "db" {
  vpc_id = aws_vpc.this.id
  cidr_block = local.subnet_list[1]
  tags = {
    Name = "${var.name}-Database"
  }
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.this.id
  cidr_block = local.subnet_list[2]
  tags = {
    Name = "${var.name}-Public"
  }
}

resource "aws_subnet" "test" {
  vpc_id = aws_vpc.this.id
  cidr_block = local.subnet_list[3]
  tags = {
    Name = "${var.name}-Test"
  }
}




