
#create Subnet
resource "azurerm_subnet" "appsubnet" {
  name                 = "appsubnet-1"
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes     = ["10.0.11.0/24"]
}

#network security group
resource "azurerm_network_security_group" "app-subnet-nsg" {
  name = "app-nsg"
  location = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
}

#association of subnet and nsg
resource "azurerm_subnet_network_security_group_association" "app-subnet-nsg-associate" {
  depends_on = [
    azurerm_network_security_rule.app-nsg-rule-inbound
  ]
  subnet_id = azurerm_subnet.appsubnet.id
  network_security_group_id = azurerm_network_security_group.app-subnet-nsg.id
}

#create nsg rule
resource "azurerm_network_security_rule" "app-nsg-rule-inbound" {
  for_each = {
    "100" :"80",
    "110" :"443",
    "120":"22"
  }

  name = "Rule-Port-${each.value}"
  priority = each.key
  direction = "Inbound"
  access = "Allow"
  protocol = "Tcp"
  source_port_range = "*"
  destination_port_range = each.value
  source_address_prefix = "*"
  destination_address_prefix = "*"
  resource_group_name = azurerm_resource_group.myrg.name
  network_security_group_name = azurerm_network_security_group.app-subnet-nsg.name
}



