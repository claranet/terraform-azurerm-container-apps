output "aca" {
  description = "Azure Container Apps output object"
  value       = azurerm_container_app.main
}

output "aca_id" {
  description = "Azure Container Apps ID"
  value       = azurerm_container_app.main.id
}

output "aca_name" {
  description = "Azure Container Apps name"
  value       = azurerm_container_app.main.name
}

output "aca_identity_principal_id" {
  description = "Azure Container Apps system identity principal ID"
  value       = try(azurerm_container_app.main.identity[0].principal_id, null)
}

output "aca_custom_domain_verification_id" {
  description = "ID of the Custom Domain Verification for this Container App."
  value       = azurerm_container_app.main.custom_domain_verification_id
}

output "aca_latest_revision_fqdn" {
  description = "FQDN of the Latest Revision of the Container App."
  value       = azurerm_container_app.main.latest_revision_fqdn
}

output "aca_latest_revision_name" {
  description = "Name of the latest Container Revision."
  value       = azurerm_container_app.main.latest_revision_name
}

output "aca_outbound_ip_addresses" {
  description = "List of the Public IP Addresses which the Container App uses for outbound network access."
  value       = azurerm_container_app.main.outbound_ip_addresses
}
