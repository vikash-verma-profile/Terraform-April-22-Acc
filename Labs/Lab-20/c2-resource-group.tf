resource "azurerm_resource_group" "myrg" {
 name="${data.azurerm_resource_group.rgds.name}-1"
 location = "East Us"
}