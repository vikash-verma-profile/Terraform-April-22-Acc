
#<block-type> <Block-label>
#{
    #<block body>
#}

#resource example
/*
resource "aws_instance" "ec2demo" {
  
}

Bl
*/#Block 1 --Terraform setting block
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
#Block 3: resource block

resource "aws_vpc" "vpc-dev" {
 cidr_block="10.0.0.0/16" 
 tags = {
   "Name" = "myvpc"
 }
}