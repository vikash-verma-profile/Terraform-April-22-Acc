#azure virtual machine scale set
resource "azurerm_linux_virtual_machine_scale_set" "web_vmss" {
  name = "web-vmss-1"
  resource_group_name = azurerm_resource_group.myrg.name
  location = azurerm_resource_group.myrg.location
  sku = "Standard_DS1_v2"
  admin_username = "azureuser"
  admin_password = "Azureuser!123"
  instances = 2
  disable_password_authentication = false
  os_disk{
    storage_account_type = "Standard_LRS"
    caching="ReadWrite"
  }

  upgrade_mode = "Automatic"
  network_interface {
    name="web-vmss-nic"
    primary=true
    network_security_group_id=azurerm_network_security_group.web-subnet-nsg.id
    ip_configuration {
      name="internal"
      primary = true
      subnet_id = azurerm_subnet.websubnet.id
    }
  }

  source_image_reference {
    publisher = "RedHat"
    offer = "RHEL"
    sku = "83-gen2"
    version = "latest"
  }

  tags = {
    "vm" = "Linux"
  }
}
