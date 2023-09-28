resource "azurerm_container_app_environment" "aca_env" {
  name                = local.aca_env_name
  location            = var.location
  resource_group_name = var.resource_group_name

  dapr_application_insights_connection_string = var.dapr_application_insights_connection_string
  infrastructure_subnet_id                    = var.infrastructure_subnet_id
  # internal_load_balancer_enabled              = var.internal_load_balancer_enabled
  # zone_redundancy_enabled                     = var.zone_redundancy_enabled

  log_analytics_workspace_id = var.log_analytics_workspace_id

  tags = merge(var.extra_tags, local.default_tags)
}

module "aca" {
  source = "./module/container-app"

  client_name         = var.client_name
  environment         = var.environment
  location_short      = var.location_short
  resource_group_name = var.resource_group_name
  stack               = var.stack

  use_caf_naming                  = var.use_caf_naming
  name_prefix                     = var.name_prefix
  name_suffix                     = var.name_suffix
  aca_custom_name                 = var.aca_custom_name
  custom_diagnostic_settings_name = var.custom_diagnostic_settings_name

  container_app_environment_id = azurerm_container_app_environment.aca_env.id

  container_configuration = var.container_configuration

  dapr_configuration     = var.dapr_configuration
  ingress_configuration  = var.ingress_configuration
  registry_configuration = var.registry_configuration
  secret_configuration   = var.secret_configuration

  identity = var.identity

  logs_destinations_ids   = var.logs_destinations_ids
  logs_categories         = var.logs_categories
  logs_metrics_categories = var.logs_metrics_categories

  extra_tags = var.extra_tags
}
