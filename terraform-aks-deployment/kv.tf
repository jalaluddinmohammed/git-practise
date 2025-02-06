
data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "kv" {
  name                        = "aks-keyvault-test1386"
  location                    = azurerm_resource_group.aks.location
  resource_group_name         = azurerm_resource_group.aks.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "List"
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set"
    ]

    storage_permissions = [
      "Get",
      "List",
      "Set"
    ]
  }
}


resource "azurerm_key_vault_secret" "secret" {
  name         = azuread_service_principal.spn.display_name
  value        = azuread_service_principal_password.password.value
  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [ azurerm_key_vault.kv ]
}


