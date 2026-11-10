module "container_app" {
  source  = "claranet/container-apps/azurerm"
  version = "x.x.x"

  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.name

  client_name = var.client_name
  environment = var.environment
  stack       = var.stack

  containers = [
    {
      name   = "helloworld"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    },
  ]

  # Optional jobs in the same environment, by key (exactly one trigger each)
  container_app_jobs = {
    nightly = {
      schedule_trigger_config = {
        cron_expression = "0 22 * * *"
      }
      replica_timeout_in_seconds = 600
      containers = [
        {
          name   = "job"
          image  = "mcr.microsoft.com/k8se/quickstart-jobs:latest"
          cpu    = 0.25
          memory = "0.5Gi"
        },
      ]
    }
  }

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
