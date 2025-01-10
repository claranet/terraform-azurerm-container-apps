output "resource" {
  description = "Container App Environment resource object."
  value       = azurerm_container_app_environment.main
}

output "id" {
  description = "The ID of the Container App Environment."
  value       = azurerm_container_app_environment.main.id
}

output "custom_domain_verification_id" {
  description = "he ID of the Custom Domain Verification for this Container App Environment."
  value       = azurerm_container_app_environment.main.custom_domain_verification_id
}

output "default_domain" {
  description = "The default, publicly resolvable, name of this Container App Environment."
  value       = azurerm_container_app_environment.main.default_domain
}

output "docker_bridge_cidr" {
  description = "The network addressing in which the Container Apps in this Container App Environment will reside in CIDR notation."
  value       = azurerm_container_app_environment.main.docker_bridge_cidr
}

output "platform_reserved_cidr" {
  description = "The IP range, in CIDR notation, that is reserved for environment infrastructure IP addresses."
  value       = azurerm_container_app_environment.main.platform_reserved_cidr
}

output "platform_reserved_dns_ip_address" {
  description = "The IP address from the IP range defined by `platform_reserved_cidr` that is reserved for the internal DNS server."
  value       = azurerm_container_app_environment.main.platform_reserved_dns_ip_address
}

output "static_ip_address" {
  description = "The Static IP address of the Environment."
  value       = azurerm_container_app_environment.main.static_ip_address
}
