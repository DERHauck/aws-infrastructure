locals {
  cluster_name = "Kateops"

  # Used to determine correct partition (i.e. - `aws`, `aws-gov`, `aws-cn`, etc.)
  partition = data.aws_partition.current.partition

  vpc_cidr = "10.0.0.0/16"
  availability_zones = ["eu-central-1a", "eu-central-1b"]
}

data "aws_partition" "current" {}
data "aws_availability_zones" "available" {}