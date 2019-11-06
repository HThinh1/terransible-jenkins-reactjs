provider "aws" {
  region = "${var.aws_region}"
}

module "aws_vpc" {
  source       = "../modules/aws_vpc"
  vpc_cidr     = "${var.vpc_cidr}"
  cidrs        = "${var.cidrs}"
  PROJECT_NAME = "${var.PROJECT_NAME}"
}

module "aws_security_groups" {
  source       = "../modules/aws_security_groups"
  vpc_id       = "${module.aws_vpc.vpc_id}"
  PROJECT_NAME = "${var.PROJECT_NAME}"
}

module "aws_instances" {
  source            = "../modules/aws_instances"
  instance_type     = "${var.instance_type}"
  ami_id            = "${var.ami_id}"
  public_key_path   = "${var.public_key_path}"
  web_dev_sg_id     = "${module.aws_security_groups.web_dev_sg_id}"
  jenkins_sg_id     = "${module.aws_security_groups.jenkins_sg_id}"
  public_subnet_id  = "${module.aws_vpc.public_subnet_id}"
  private_subnet_id = "${module.aws_vpc.private_subnet_id}"
  PROJECT_NAME      = "${var.PROJECT_NAME}"
}

module "aws_alb" {
  source            = "../modules/aws_app_load_balancer"
  vpc_id            = "${module.aws_vpc.vpc_id}"
  PROJECT_NAME      = "${var.PROJECT_NAME}"
  react_instance_id = "${module.aws_instances.react_instance_id}"
  web_dev_sg_id     = "${module.aws_security_groups.web_dev_sg_id}"
  public_subnet_id  = "${module.aws_vpc.public_subnet_id}"
  public1_subnet_id = "${module.aws_vpc.public1_subnet_id}"
}

module "aws_autoscaling_group" {
  source               = "../modules/aws_auto_scaling"
  PROJECT_NAME         = "${var.PROJECT_NAME}"
  react_instance_id    = "${module.aws_instances.react_instance_id}"
  web_dev_sg_id        = "${module.aws_security_groups.web_dev_sg_id}"
  keypair_auth_id      = "${module.aws_instances.keypair_auth_id}"
  lc_instance_type     = "${var.lc_instance_type}"
  target_group_arn     = "${module.aws_alb.target_group_arn}"
  public1_subnet_id    = "${module.aws_vpc.public1_subnet_id}"
  public_subnet_id     = "${module.aws_vpc.public_subnet_id}"
  alb_target_group_arn = "${module.aws_alb.target_group_arn}"
  asg_min_size         = "${var.asg_min_size}"
  asg_max_size         = "${var.asg_max_size}"
  asg_cap              = "${var.asg_cap}"
  asg_grace            = "${var.asg_grace}"
  asg_hct              = "${var.asg_hct}"
}

module "aws_autoscaling_policy" {
  source   = "../modules/aws_auto_scaling_policy"
  asg_name = "${module.aws_autoscaling_group.asg_name}"
}

