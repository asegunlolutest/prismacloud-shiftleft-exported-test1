output "resource_group_name" {
    value = azurerm_resource_group.rg.name
}
output "storage_acct_name" {
    value = azurerm_storage_account.storage.name
}
output "managed_disk_name" {
    value = azurerm_managed_disk.disk.name
}