resource "azurerm_storage_account" "sa" {
 count                 = var.count 
 name                  = "acctvm${count.index}"
 location              = azurerm_resource_group.rg.location
 availability_set_id   = azurerm_availability_set.avset.id
 resource_group_name   = azurerm_resource_group.rg.name
 network_interface_ids = [element(azurerm_network_interface.rg.*.id, count.index)]
 vm_size               = "Standard_DS1_v2"
 }