module "container_app_job" {
  source  = "claranet/container-apps/azurerm//modules/container-app-job"
  version = "x.x.x"

  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.name

  container_app_environment_id = var.container_app_environment_id

  client_name = var.client_name
  environment = var.environment
  stack       = var.stack

  schedule_trigger_config = {
    cron_expression = "0 22 * * *"
  }
  replica_timeout_in_seconds = 600
  replica_retry_limit        = 0

  containers = [
    {
      name   = "job"
      image  = "mcr.microsoft.com/k8se/quickstart-jobs:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    },
  ]

  extra_tags = {
    foo = "bar"
  }
}
