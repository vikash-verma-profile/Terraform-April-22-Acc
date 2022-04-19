resource "azurerm_windows_virtual_machine" "mylinuxvm" {
  name = "mylinuxvm-2"
  computer_name = "devlinux-vm1" #hostname of the vm
  resource_group_name = azurerm_resource_group.myrg.name
  location = azurerm_resource_group.myrg.location
  size = "Standard_F2"
  #disable_password_authentication=false
  admin_username = "azureuser"
  network_interface_ids = [azurerm_network_interface.myvmnic.id]
  admin_password = "Levelup@007"
  os_disk {
    name="osdisk"
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer = "WindowsServer"
    sku = "2016-Datacenter"
    version = "latest"
  }

}