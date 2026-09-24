module "container_app_environment" {
  source  = "claranet/container-apps/azurerm//modules/container-app-environment"
  version = "x.x.x"

  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.name

  client_name = var.client_name
  environment = var.environment
  stack       = var.stack

  # Diagnostic settings of the environment
  logs_destinations_ids = [
    module.logs.storage_account_id,
    module.logs.id,
  ]

  # Container console/system logs sent directly to a Log Analytics Workspace.
  # Omit to keep the `azure-monitor` mode (logs routed by the diagnostic settings).
  log_analytics_workspace = {
    id = module.logs.id
  }

  extra_tags = {
    foo = "bar"
  }
}
