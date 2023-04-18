storage_account = {
    sa1 =  {

      name                   = "1mystor1234567"
      resource_group_name    = "ramireddy"
      location               = "west india"
      account_kind           = "StorageV2"
      account_replication_type     = "LRS"
      account_tier           = "Standard"
            },
    sa2 = {
      name                  = "2mystor2345678"
      resource_group_name   = "ramireddy"
      location              = "west india"
      account_kind          = "StorageV2"
      account_replication_type     = "GRS"
      account_tier          = "Standard"
    },

     sa3 = {
      name                  = "3mystor2345678"
      resource_group_name   = "ramireddy"
      location              = "west india"
      account_kind     = "StorageV2"
      account_replication_type     = "GRS"
      account_tier          = "Standard"
    }
}
