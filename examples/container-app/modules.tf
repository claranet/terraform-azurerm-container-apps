module "container_app" {
  source  = "claranet/container-apps/azurerm//modules/container-app"
  version = "x.x.x"

  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.name

  container_app_environment_id = var.container_app_environment_id

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

  extra_tags = {
    foo = "bar"
  }
}
