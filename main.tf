resource "azurerm_resource_group" "rg" {
  for_each = var.resourcedetails

  name     = each.value.rg_name
  location = each.value.location
}
resource "azurerm_virtual_network" "vnet" {
  for_each = var.resourcedetails
  name                = each.value.vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = each.value.azurerm_resource_group.rg.location
  resource_group_name = each.value.azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  for_each = var.resourcedetails

  name                 = each.value.subnet_name
  address_prefixes     = ["10.0.0.0/24"]
  virtual_network_name = each.value.azurerm_virtual_network.vnet.name
  resource_group_name  = each.value.azurerm_resource_group.rg.name
}

resource "azurerm_network_interface" "mynic" {
  for_each = var.resourcedetails

  name                = "my-nic"  
  location            = each.value.azurerm_resource_group.rg.location
  resource_group_name = each.value.azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "my-ip-config"
    subnet_id                     = azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_network_security_group" "nsg" {
  for_each = var.resourcedetails

  name                = each.value.nsg_rules
  location            = each.value.azurerm_resource_group.rg.location
  resource_group_name = each.value.azurerm_resource_group.rg.name
}

resource "azurerm_network_security_rule" "nsg_rule" {
  for_each = var.resourcedetails

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = each.value.azurerm_resource_group.rg.name
  network_security_group_name= each.value.azurerm_network_security_group.nsg.name
}

resource "azurerm_virtual_machine" "vm" {
  for_each = var.resourcedetails

  name                  = each.value.vm_name
  location              = each.value.azurerm_resource_group.rg.location
  resource_group_name   = each.value.azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.mynic[each.key].id]
  vm_size               = each.value.size

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${each.value.name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = each.value.name
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  
}