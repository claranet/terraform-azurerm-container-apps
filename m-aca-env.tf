module "aca_env" {
  source = "./module/aca-environment"

  client_name         = var.client_name
  environment         = var.environment
  location_short      = var.location_short
  stack               = var.stack
  location            = var.location
  resource_group_name = var.resource_group_name

  custom_name = var.aca_env_custom_name

  dapr_application_insights_connection_string = var.dapr_application_insights_connection_string
  # infrastructure_subnet_id                    = var.infrastructure_subnet_id
  # internal_load_balancer_enabled              = var.internal_load_balancer_enabled
  # zone_redundancy_enabled                     = var.zone_redundancy_enabled

  log_analytics_workspace_id = var.log_analytics_workspace_id

  default_tags_enabled = var.default_tags_enabled
  extra_tags           = var.extra_tags
}
