
# Create multiple virtual machines
resource "azurerm_virtual_machine" "vm" {
  count = var.num_vms
  
  name                  = "vm${count.index + 1}"
  location              = var.location
  resource_group_name   = var.rg_name
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  
  storage_os_disk {
    name              = "${var.os_disk_name}${count.index + 1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }
  
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = var.image_name
    version   = "latest"
  }
  
  os_profile {
    computer_name  = "vm${count.index + 1}"
    admin_username = "adminuser"
  }
  
  os_profile_linux_config {
    disable_password_authentication = true
  }
  
  hardware_profile {
    vm_size = var.vm_size
  }
}

# Create network interface for each VM
resource "azurerm_network_interface" "nic" {
  count = var.num_vms
  
  name                = "nic${count.index + 1}"
  location            = var.location
  resource_group_name = var.rg_name
  
  ip_configuration {
    name                          = "ipconfig${count.index + 1}"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
  
  depends_on = [azurerm_subnet_network_security_group_association.subnet_nsg_assoc]
}

# Create subnet for the virtual network
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = ["10.0.1.0/24"]
}

# Associate subnet with network security group
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_assoc" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Create network security group
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg"
  location            = var.location
  resource_group_name = var.rg_name
  
  security_rule {
    name                       = "allow_ssh"
    priority                   = 1000
    direction                  = "Inbound
