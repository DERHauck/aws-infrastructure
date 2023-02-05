module "vpc" {
  source = "../module/vpc"
  name = "Kateops"
  cidr_block = "10.1.0.0/16"
}
