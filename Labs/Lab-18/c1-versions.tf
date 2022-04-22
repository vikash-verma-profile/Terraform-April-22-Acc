terraform {
  required_version = ">=1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.0"
    }
  }
}
#Block 2--Provider block
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "myrg" {
 name="myrg-2" 
 location = "East Us"
}


module "vnet" {
  source  = "Azure/vnet/azurerm"
  # insert the 2 required variables here

  resource_group_name =azurerm_resource_group.myrg.name
  vnet_location =azurerm_resource_group.myrg.location
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}