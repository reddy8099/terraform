resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}
resource "azurerm_role_assignment" "role_acrpull" {

    scope                             = azurerm_container_registry.acr.id
    role_definition_name              = "Acrpull"
    principle_id                      = azurerm_kubernetes_cluster.aks.kubelet_identity.0.object_id
    skip_service_principle_aaa_check  = true

}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false  
  
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.cluster_name
default_node_pool {
    name                = "system"
    vm_size             = "Standard_DS2_v2"
    node_count          = var.system_node_count
    type                = "virtualmachineScaleSets"
    availability_zones   = "Zones 1,2,3"
    enable_auto_scaling = false

  }

  identity {
    type = "systemAssigned"
    
  }
  
  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "kubenet"
  }
}