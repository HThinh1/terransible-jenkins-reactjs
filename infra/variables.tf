variable "aws_region" {}
variable "vpc_cidr" {}

variable "cidrs" {
  type = "map"
}

variable "ami_id" {}
variable "instance_type" {}
variable "public_key_path" {}
variable "PROJECT_NAME" {}
variable "asg_grace" {}
variable "asg_hct" {}
variable "lc_instance_type" {}
variable "asg_max_size" {}
variable "asg_min_size" {}
variable "asg_cap" {}
