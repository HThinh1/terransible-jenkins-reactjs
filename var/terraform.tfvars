# AWS Config
aws_region = "us-east-1"
profile = "devops"

# VPC vars
vpc_cidr = "10.0.0.0/16"
cidrs = {
  public = "10.0.0.0/24"
  private = "10.0.1.0/24"
}

localip = "120.72.83.18/32"

# Instance vars
key_name = "kryptonite"
ami_id = "ami-0b69ea66ff7391e80"
instance_type = "t2.micro"
public_key_path = "/root/.ssh/kryptonite.pub"
project_name = "test"