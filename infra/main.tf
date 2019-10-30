provider "aws" {
  region     = "${var.aws_region}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

module "aws_vpc" {
  source = "../modules/aws_vpc"

  #VPC block
  vpc_cidr = "${var.vpc_cidr}"

  #Subnet block
  cidrs = "${var.cidrs}"
}
