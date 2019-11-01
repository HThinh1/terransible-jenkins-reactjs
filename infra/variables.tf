variable "aws_region" {}
variable "profile" {}
variable "vpc_cidr" {}
variable "cidrs" {
  type = "map"
}
variable "localip" {}
variable "ami_id" {}
variable "key_name" {}
variable "instance_type" {}
variable "public_key_path" {}
variable "project_name" {}