variable "vpc_cidr" {}
data "aws_availability_zones" "available" {}
variable "cidrs" {
  type = "map"
}
variable "PROJECT_NAME" {}
