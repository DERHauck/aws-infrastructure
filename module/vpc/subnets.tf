resource "aws_subnet" "private" {
  vpc_id = aws_vpc.this.id
  availability_zone = local.availability_zones[0]
  cidr_block = local.subnet_list[0]
  tags = merge({
    Name = "${var.name}-Private"
  }, local.private_cluster_tags)
}

/*
resource "aws_subnet" "backup" {
  count = 0
  vpc_id = aws_vpc.this.id
  availability_zone = "eu-central-1a"
  cidr_block = local.subnet_list[0]
  tags = {
    Name = "${var.name}-Backup"
  }
}
*/
resource "aws_subnet" "database" {
  vpc_id = aws_vpc.this.id
  availability_zone = local.availability_zones[0]
  cidr_block = local.subnet_list[1]
  tags = {
    Name = "${var.name}-Database"
  }
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.this.id
  availability_zone = local.availability_zones[0]
  cidr_block = local.subnet_list[2]
  tags = merge({
    Name = "${var.name}-Public"
  }, local.public_cluster_tags)
}

resource "aws_subnet" "test" {
  vpc_id = aws_vpc.this.id
  availability_zone = local.availability_zones[1]
  cidr_block = local.subnet_list[3]
  tags = merge({
    Name = "${var.name}-Test"
  }, local.private_cluster_tags)
}




