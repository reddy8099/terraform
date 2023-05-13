resource "azurerm_resource_group" "rg" {
  name     = "ramireddy12"
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "ram-vnet"
  address_space       = ["10.10.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Define subnet
resource "azurerm_subnet" "subnet" {
  name                 = "ram-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.10.1.0/24"]
}

# Define network interface
resource "azurerm_network_interface" "nic" {
  name                = "ram-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ramipc"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_network_security_group" "nsg" {
  name = "ram-nsg"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  
}

# Define virtual machine
resource "azurerm_virtual_machine" "main"{
  name                  = "ramvm0452tf12"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
 
  storage_os_disk {
    name              = "FrompackerImageosDisk"
    managed_disk_type = "Standard_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    
  }
   os_profile {
    computer_name  = "PackervmTEST"
    admin_username = "testuser"
    admin_password = "Rami@8099"
  }

 os_profile_linux_config {
    disable_password_authentication = false
  }
 }
