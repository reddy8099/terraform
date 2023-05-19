
 resource "azurerm_windows_virtual_machine" "vm" {
  for_each            = var.vm
  name                = each.value.name
  resource_group_name = azurerm_resource_group.demo-rg.name
  location            = var.location
  size                = each.value.size
  admin_username      = var.vm_admin_login
  admin_password      = var.vm_admin_password

  network_interface_ids = [azurerm_network_interface.nic[each.key].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  
   source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}