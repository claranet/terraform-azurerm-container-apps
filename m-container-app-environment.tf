module "container_app_environment" {
  source = "./modules/container-app-environment"

  client_name         = var.client_name
  environment         = var.environment
  location_short      = var.location_short
  stack               = var.stack
  location            = var.location
  resource_group_name = var.resource_group_name

  name_prefix = var.name_prefix
  name_suffix = var.name_suffix
  custom_name = var.container_app_environment_custom_name

  dapr_application_insights_connection_string = var.dapr_application_insights_connection_string
  infrastructure_resource_group_name          = var.infrastructure_resource_group_name
  infrastructure_subnet                       = var.infrastructure_subnet
  internal_load_balancer_enabled              = var.internal_load_balancer_enabled
  zone_redundancy_enabled                     = var.zone_redundancy_enabled

  logs_destinations_ids           = var.logs_destinations_ids
  logs_categories                 = var.logs_categories
  logs_metrics_categories         = var.logs_metrics_categories
  diagnostic_settings_custom_name = var.diagnostic_settings_custom_name

  workload_profile   = var.workload_profile
  mutual_tls_enabled = var.mutual_tls_enabled

  certificate                           = var.certificate
  custom_domain_enabled                 = var.custom_domain_enabled
  custom_domain_certificate_blob_base64 = var.custom_domain_certificate_blob_base64
  custom_domain_certificate_password    = var.custom_domain_certificate_password
  custom_domain_dns_suffix              = var.custom_domain_dns_suffix

  dapr_components = var.dapr_components

  storage = var.storage

  default_tags_enabled = var.default_tags_enabled
  extra_tags           = var.extra_tags
}
