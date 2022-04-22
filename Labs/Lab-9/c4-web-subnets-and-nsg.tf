
#create Subnet
resource "azurerm_subnet" "websubnet" {
  name                 = "mysubnet-1"
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

#network security group
resource "azurerm_network_security_group" "web-subnet-nsg" {
  name = "web-nsg"
  location = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
}

#association of subnet and nsg
resource "azurerm_subnet_network_security_group_association" "web-subnet-nsg-associate" {
  depends_on = [
    azurerm_network_security_rule.web-nsg-rule-inbound
  ]
  subnet_id = azurerm_subnet.websubnet.id
  network_security_group_id = azurerm_network_security_group.web-subnet-nsg.id
}

#create nsg rule
resource "azurerm_network_security_rule" "web-nsg-rule-inbound" {
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
  network_security_group_name = azurerm_network_security_group.web-subnet-nsg.name
}








# #Create Public Ip 
# resource "azurerm_public_ip" "mypublicip" {
#   depends_on = [
#     azurerm_virtual_network.myvnet,
#     azurerm_subnet.mysubnet
#   ]
#   name                = "mypublicip-2"
#   resource_group_name = azurerm_resource_group.myrg.name
#   location            = azurerm_resource_group.myrg.location
#   allocation_method   = "Static"
#   tags = {
#     environment = "Dev"
#   }
# }
# #create Network Intergface
# resource "azurerm_network_interface" "myvmnic" {
#   name                = "vmnic-1"
#   location            = azurerm_resource_group.myrg.location
#   resource_group_name = azurerm_resource_group.myrg.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.mysubnet.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.mypublicip.id
#   }
# }