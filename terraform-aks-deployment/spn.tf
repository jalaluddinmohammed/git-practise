data "azuread_client_config" "current" {}



resource "azuread_application" "spn-app" {
  display_name = var.spn-app
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "spn" {
  client_id                    = azuread_application.spn-app.client_id
  app_role_assignment_required = true
  owners                       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal_password" "password" {
  service_principal_id = azuread_service_principal.spn.id
}
