data "azurecaf_name" "acj" {
  # "caj" in the name, not as a prefix: azurecaf trims prefixes first when the name is too long.
  name          = join("-", ["caj", var.stack])
  resource_type = "azurerm_container_app" # azurerm_container_app_job NOT AVAILABLE YET, same naming rules
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix])
  use_slug      = false
  clean_input   = true
  separator     = "-"
}
