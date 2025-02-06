output "spn-name" {
  value = azuread_service_principal.spn.display_name
}

output "object_id" {
  value = azuread_application.spn-app.object_id
}

output "client_id" {
  value = azuread_service_principal.spn.client_id
}

output "tenant_id" {
  value = azuread_service_principal.spn.application_tenant_id
}


output "client_secret" {
  value = azuread_service_principal_password.password.value
  sensitive = true
}

