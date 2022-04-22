variable "environment" {
  type=string
  description = "Please enter environment"
}
resource "azurerm_resource_group" "myrg" {
 name=(var.environment=="Dev")?"myrg-dev" :"myrg-prod"
 location = "East Us"
}