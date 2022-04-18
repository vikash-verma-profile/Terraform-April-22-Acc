#Block 1 --Terraform setting block
terraform{
    required_version=">=1.0.0"
    required_providers{
        azurerm={
            source="hashicorp/azurerm"
            version=">=2.0"
        }
    }
}
#Block 2--Provider block
provider "azurerm" {
  features {
    
  }
}
#Block 3: resource block
resource "azurerm_resource_group" "myrg" {
 name = "myrg-1"
 location = "eastus"
}