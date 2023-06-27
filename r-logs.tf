module "diagnostics" {
  source  = "claranet/diagnostic-settings/azurerm"
  version = "~> 6.4.1"

  resource_id = azurerm_container_app.aca.id

  logs_destinations_ids = var.logs_destinations_ids
  log_categories        = var.logs_categories
  metric_categories     = var.logs_metrics_categories
  retention_days        = var.logs_retention_days

  custom_name = var.custom_diagnostic_settings_name
  name_prefix = var.name_prefix
  name_suffix = var.name_suffix
}

module "aca_logs" {
  source  = "claranet/run/azurerm//modules/logs"
  version = "~> 7.2.1"

  client_name    = var.client_name
  location       = var.location
  location_short = var.location_short
  environment    = var.environment
  stack          = var.stack

  resource_group_name = var.resource_group_name

  # extra_tags = {
  #   foo    = "bar"
  # }
}
