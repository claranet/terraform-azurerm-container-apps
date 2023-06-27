output "aca" {
  description = "Azure Container Apps output object"
  value       = azurerm_container_app.aca
}

output "id" {
  description = "Azure Container Apps ID"
  value       = azurerm_container_app.aca.id
}

output "name" {
  description = "Azure Container Apps name"
  value       = azurerm_container_app.aca.name
}

output "identity_principal_id" {
  description = "Azure Container Apps system identity principal ID"
  value       = try(azurerm_container_app.aca.identity[0].principal_id, null)
}
