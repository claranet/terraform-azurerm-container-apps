output "resource" {
  description = "Azure Container App Job resource object."
  value       = azurerm_container_app_job.main
  sensitive   = true
}

output "id" {
  description = "Azure Container App Job ID."
  value       = azurerm_container_app_job.main.id
}

output "name" {
  description = "Azure Container App Job name."
  value       = azurerm_container_app_job.main.name
}

output "identity_principal_id" {
  description = "Azure Container App Job system identity principal ID."
  value       = try(azurerm_container_app_job.main.identity[0].principal_id, null)
}

output "event_stream_endpoint" {
  description = "Endpoint of the event stream of the Container App Job."
  value       = azurerm_container_app_job.main.event_stream_endpoint
}

output "outbound_ip_addresses" {
  description = "List of the Public IP Addresses which the Container App Job uses for outbound network access."
  value       = azurerm_container_app_job.main.outbound_ip_addresses
}
