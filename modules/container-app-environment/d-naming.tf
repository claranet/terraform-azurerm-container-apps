data "azurecaf_name" "container_app_environment" {
  name          = var.stack
  resource_type = "azurerm_container_app_environment"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix])
  use_slug      = true
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "infrastructure_rg" {
  count = var.infrastructure_subnet != null ? 1 : 0

  name          = local.name
  resource_type = "azurerm_resource_group"
  suffixes      = ["cae"]
  use_slug      = true
  clean_input   = true
  separator     = "-"
}
