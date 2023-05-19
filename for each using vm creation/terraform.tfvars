default = {
    eastus2 = {
      rg_name       = "Ramireddy"  
      name          = "west-vm"
      location      = "eastus2"
      size          = "Standard_B1s"
      vnet_name     = "west-vnet"
      subnet_name   = "west-subnet"
    }
    eastus = {
      rg_name       = "Eastus-rg"  
      name          = "east-vm"
      location      = "eastus"
      size          = "Standard_B1s"
      vnet_name     = "east-vnet"
      subnet_name   = "east-subnet"
    }
  }
  Default = {
nsg_rules = [
  {
        name = "nsg1"
        security_rule = [
      {
        name                       = "rule1"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "0.0.0.0/0"
        destination_address_prefix = "*"
      }
        ],
      
      name = "nsg2"
      security_rule = [ 
        {
        name                       = "rule2"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "0.0.0.0/0"
        destination_address_prefix = "*"
        }
      ]
   
    }
     
]
  }




