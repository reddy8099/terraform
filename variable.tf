variable "resourcedetails" {
  type = map(object({
    vm_name         = string
    location        = string
    size            = string
    rg_name         = string
    vnet_name       = string
    subnet_name     = string
    nsg_rules       = string
  
 
  
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))

}
