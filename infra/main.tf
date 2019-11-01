provider "aws" {
  region = "${var.aws_region}"
}

module "aws_vpc" {
  source = "../modules/aws_vpc"

  #VPC block
  vpc_cidr = "${var.vpc_cidr}"

  #Subnet block
  cidrs = "${var.cidrs}"
}

module "aws_security_groups" {
  source = "../modules/aws_security_groups"
  vpc_id = "${module.aws_vpc.vpc_id}" 
  vpc_cidr = "${var.vpc_cidr}"
  localip = "${var.localip}"
}

module "aws_instances" {
  source = "../modules/aws_instances"
  instance_type = "${var.instance_type}"
  ami_id = "${var.ami_id}"
  key_name = "${var.key_name}"
  public_key_path = "${var.public_key_path}"
  public_sg_id = "${module.aws_security_groups.public_sg_id}"
  private_sg_id = "${module.aws_security_groups.private_sg_id}"
  jenkins_sg_id = "${module.aws_security_groups.jenkins_sg_id}"
  public_subnet_id = "${module.aws_vpc.public_subnet_id}"
  private_subnet_id = "${module.aws_vpc.private_subnet_id}"
  project_name = "${var.project_name}"
}
