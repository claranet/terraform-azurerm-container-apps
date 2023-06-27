locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  aca_name     = coalesce(var.aca_custom_name, data.azurecaf_name.aca.result)
  aca_env_name = coalesce(var.aca_env_custom_name, data.azurecaf_name.aca.result)
}
