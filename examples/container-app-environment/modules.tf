module "containerapp_environment" {
  source  = "claranet/aca/azurerm///module/container-app-environment"
  version = "x.x.x"

  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.name

  client_name = var.client_name
  environment = var.environment
  stack       = var.stack

  extra_tags = {
    foo = "bar"
  }
}
