terraform{
    required_version=">=1.0.0"
    required_providers{
        aws={
            source="hashicorp/aws"
            version="~>3.0"
        }
    }
}
#Block 2--Provider block
provider "aws" {
  region = "us-east-1"
  profile = "default"
}

resource "aws_instance" "my-ec2-vm1" {
  ami=var.ec2_ami_id
  instance_type = "t2.micro"
  count = var.ec2_instace_count
  tags = {
    "Name" = "myec2vm"
  }
}
