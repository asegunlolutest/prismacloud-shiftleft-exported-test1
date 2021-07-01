resource "azurerm_managed_disk" "disk" {
  name                 = "evilpetclinic-disk-${var.environment}"
  location             = var.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 1
  encryption_settings {
    enabled = false
  }
}

resource "azurerm_storage_account" "storage" {
  name                     = "tgsa${var.environment}${random_integer.rnd_int.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  queue_properties {
    logging {
      delete                = false
      read                  = false
      write                 = true
      version               = "1.0"
      retention_policy_days = 10
    }
    hour_metrics {
      enabled               = true
      include_apis          = true
      version               = "1.0"
      retention_policy_days = 10
    }
    minute_metrics {
      enabled               = true
      include_apis          = true
      version               = "1.0"
      retention_policy_days = 10
    }
  }
}

resource "azurerm_storage_account_network_rules" "rule" {
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_name = azurerm_storage_account.storage.name

  default_action = "Deny"
  ip_rules       = ["127.0.0.1"]
  bypass         = ["Metrics"]
}
