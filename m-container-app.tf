module "aca" {
  source = "./module/container-app"

  client_name         = var.client_name
  environment         = var.environment
  location_short      = var.location_short
  resource_group_name = var.resource_group_name
  stack               = var.stack

  name_prefix     = var.name_prefix
  name_suffix     = var.name_suffix
  aca_custom_name = var.aca_custom_name

  container_app_environment_id = module.aca_env.id

  containers = var.containers

  daprs      = var.daprs
  ingresses  = var.ingresses
  registries = var.registries
  secrets    = var.secrets

  identity = var.identity

  default_tags_enabled = var.default_tags_enabled
  extra_tags           = var.extra_tags
}
