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

  container_configuration = var.container_configuration

  dapr_configuration     = var.dapr_configuration
  ingress_configuration  = var.ingress_configuration
  registry_configuration = var.registry_configuration
  secret_configuration   = var.secret_configuration

  identity = var.identity

  default_tags_enabled = var.default_tags_enabled
  extra_tags           = var.extra_tags
}
