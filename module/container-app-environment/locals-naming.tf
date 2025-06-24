locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  name = coalesce(var.container_app_environment_custom_name, data.azurecaf_name.container_app_environment.result)
}
