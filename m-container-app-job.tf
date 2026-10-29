module "container_app_job" {
  source   = "./modules/container-app-job"
  for_each = var.container_app_jobs

  client_name         = var.client_name
  environment         = var.environment
  location            = var.location
  location_short      = var.location_short
  resource_group_name = var.resource_group_name
  stack               = var.stack

  name_prefix = var.name_prefix
  name_suffix = join("-", compact([var.name_suffix, each.key]))
  custom_name = each.value.custom_name

  container_app_environment_id = module.container_app_environment.id
  workload_profile_name        = each.value.workload_profile_name != null ? each.value.workload_profile_name : try(keys(var.workload_profile)[0], null)

  replica_timeout_in_seconds = each.value.replica_timeout_in_seconds
  replica_retry_limit        = each.value.replica_retry_limit

  manual_trigger_config   = each.value.manual_trigger_config
  schedule_trigger_config = each.value.schedule_trigger_config
  event_trigger_config    = each.value.event_trigger_config

  init_containers = each.value.init_containers
  containers      = each.value.containers
  volumes         = each.value.volumes
  identity        = each.value.identity
  registries      = each.value.registries
  secrets         = each.value.secrets

  default_tags_enabled = var.default_tags_enabled
  extra_tags           = var.extra_tags
}

# azurecaf trims the name suffix (job key) first when a generated name exceeds 32 characters.
check "container_app_jobs_unique_names" {
  assert {
    condition     = length(distinct([for job in module.container_app_job : job.name])) == length(module.container_app_job)
    error_message = "Several Container App Jobs get the same generated name (truncated to 32 characters): set their `custom_name` in `container_app_jobs`."
  }
}
