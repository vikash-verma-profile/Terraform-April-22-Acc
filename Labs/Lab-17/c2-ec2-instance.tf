# module "ec2-instance" {
#   source  = "terraform-aws-modules/ec2-instance/aws"
#   version = "~> 3.4.0"
#   name="sample-demo"
#   instance_count=1
#   associate_public_ip_address=true

# }

module "iam" {
  source  = "terraform-aws-modules/iam/aws"
  version = "4.20.3"
}