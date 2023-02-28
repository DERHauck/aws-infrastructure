
//*
resource "aws_instance" "nat" {
  availability_zone = local.availability_zones[0]
  instance_type = "t4g.nano"
  ami = data.aws_ami.nat.id
  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.nat.id
  }
  tags = {
    Name = "${var.name}-NAT"
  }
}

resource "aws_route" "nat" {
  route_table_id = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id = aws_network_interface.nat.id
}

data "aws_ami" "nat" {
  owners = ["568608671756"]
  filter {
    name   = "name"
    values = ["fck-nat-amzn2-hvm-1.2.0-20220812-arm64-ebs"]
  }
}

resource "aws_network_interface" "nat" {
  subnet_id = aws_subnet.public.id
  security_groups = [aws_security_group.nat.id]
  source_dest_check = false
}

resource "aws_eip" "nat" {
  instance = aws_instance.nat.id
  depends_on = [
    aws_internet_gateway.this
  ]
}


resource "aws_security_group" "nat" {
  vpc_id = aws_vpc.this.id
  ingress {
    from_port = 0
    protocol  = "TCP"
    to_port   = 65535
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol  = "TCP"
    to_port   = 65535
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port = 0
    protocol  = "UDP"
    to_port   = 65535
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol  = "UDP"
    to_port   = 65535
    cidr_blocks = ["0.0.0.0/0"]
  }



  tags = {
    Name = "${var.name}-NAT"
  }
}
//*/

/*
resource "aws_nat_gateway" "this" {
  subnet_id = aws_subnet.private.id
  allocation_id = aws_eip.this.id
}

resource "aws_eip" "this" {}

resource "aws_route" "nat" {
  route_table_id = aws_vpc.this.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.this.id
}

//*/