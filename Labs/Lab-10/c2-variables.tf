#input variables
variable "aws_region" {
  description="Region in which aws resources to be created"
  type = string
  default = "us-east-1"
}

variable "ec2_ami_id" {
  description="AMI ID"
  type = string
  default = "ami-03ededff12e34e59e"
}

variable "instance_type" {
  description="Instance type"
  type = string
  default = "t2.micro"
}

# variable "ec2_instace_count" {
#   description="EC2 Instance count"
#   type = number
# }