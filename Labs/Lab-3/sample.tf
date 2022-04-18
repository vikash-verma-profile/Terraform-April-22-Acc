terraform{
    required_version=">=1.0.0"
    required_providers{
        aws={
            source="hashicorp/aws"
            version="~>3.0"
        }
        azurerm={
            source="hashicorp/azurerm"
            version=">=2.0"
        }
    }
}
#Block 2--Provider block
provider "aws" {
  region = "us-east-1"
  profile = "default"
}
provider "azurerm" {
  features {
  }
}
#Block 3: resource block
resource "aws_vpc" "vpc-dev" {
 cidr_block="10.0.0.0/16" 
 tags = {
   "Name" = "myvpc"
 }
}
resource "azurerm_resource_group" "myrg" {
 name = "myrg-1"
 location = "eastus"
}