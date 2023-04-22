resource "azurerm_resource_group" "rg" {
  name     = "tf-using-aks"
  location = "westus2"
}

resource "azurerm_virtual_network" "v-net" {
  name                = "vnet1"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "ram-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.v-net.name
  address_prefixes     = ["10.10.1.0/24"]
}

resource "azurerm_kubernetes_cluster" "aks1" {
  name                = "my-aks-cluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "my-aks-cluster"
default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_D2_v1"
    node_count = 2
  }

  linux_profile {
    admin_username = "testuser"
    ssh_key {
      key_data = "ssh-rsa AAAAB3Nz..."
    }
  }
  agent_pool_profile {
    name            = "default"
    count           = 1
    vm_size         = "Standard_D8s_v3"
    os_type         = "Linux"
    vnet_subnet_id  = azurerm_subnet.subnet.id
  }
}