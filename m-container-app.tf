module "container_app" {
  source = "./modules/container-app"

  client_name         = var.client_name
  environment         = var.environment
  location_short      = var.location_short
  resource_group_name = var.resource_group_name
  stack               = var.stack

  name_prefix = var.name_prefix
  name_suffix = var.name_suffix
  custom_name = var.container_app_custom_name

  container_app_environment_id = module.container_app_environment.id
  revision_mode                = var.revision_mode

  init_containers                  = var.init_containers
  containers                       = var.containers
  template_max_replicas            = var.template_max_replicas
  template_min_replicas            = var.template_min_replicas
  azure_queue_scale_rules          = var.azure_queue_scale_rules
  custom_scale_rules               = var.custom_scale_rules
  http_scale_rules                 = var.http_scale_rules
  tcp_scale_rules                  = var.tcp_scale_rules
  revision_suffix                  = var.revision_suffix
  termination_grace_period_seconds = var.termination_grace_period_seconds
  volumes                          = var.volumes
  daprs                            = var.daprs
  ingresses                        = var.ingresses
  registries                       = var.registries
  secrets                          = var.secrets
  workload_profile_name            = var.workload_profile_name == null ? try(keys(var.workload_profile)[0], null) : var.workload_profile_name
  max_inactive_revisions           = var.max_inactive_revisions

  identity = var.identity

  default_tags_enabled = var.default_tags_enabled
  extra_tags           = var.extra_tags
}
