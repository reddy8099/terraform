provider "azurerm" {
    features {} 
}

resource "azurerm_storage_account" "sa" {
  for_each                 = var.storage_account
  name                     = each.value.name
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_kind             = each.value.account_kind
  account_replication_type = each.value.account_replication_type
  account_tier             = each.value.account_tier
}