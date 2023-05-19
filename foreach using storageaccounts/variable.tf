variable "storage_account" {
    type                         = map(object({
    name                         = string
    resource_group_name          = string
    location                     = string
    account_kind                 = string
    account_replication_type     = string
    account_tier                 = string
    
    }))
}