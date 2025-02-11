resource "azurerm_container_app_environment" "main" {
  name                = local.name
  location            = var.location
  resource_group_name = var.resource_group_name

  dapr_application_insights_connection_string = var.dapr_application_insights_connection_string

  infrastructure_resource_group_name = var.infrastructure_resource_group_name
  # Issue with the variable internal_load_balancer_enabled if defaulted to false as detailed in the documentation (https://github.com/hashicorp/terraform-provider-azurerm/issues/25303)
  # infrastructure_subnet_id                    = var.infrastructure_subnet_id
  # internal_load_balancer_enabled              = var.internal_load_balancer_enabled
  # zone_redundancy_enabled                     = var.zone_redundancy_enabled

  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "workload_profile" {
    for_each = var.workload_profile
    content {
      name                  = workload_profile.value.name
      workload_profile_type = workload_profile.value.workload_profile_type
      maximum_count         = workload_profile.value.maximum_count
      minimum_count         = workload_profile.value.minimum_count
    }
  }

  mutual_tls_enabled = var.mutual_tls_enabled

  tags = merge(var.extra_tags, local.default_tags)
}

resource "azurerm_container_app_environment_certificate" "main" {
  for_each = { for c in var.certificate : c.name => c }

  container_app_environment_id = azurerm_container_app_environment.main.id

  name                    = each.key
  certificate_blob_base64 = each.value.certificate_blob_base64
  certificate_password    = each.value.certificate_password
}

resource "azurerm_container_app_environment_custom_domain" "main" {
  for_each = toset(lower(var.custom_domain_enabled) == "true" ? ["enabled"] : [])

  container_app_environment_id = azurerm_container_app_environment.main.id

  certificate_blob_base64 = var.custom_domain_certificate_blob_base64
  certificate_password    = var.custom_domain_certificate_password
  dns_suffix              = var.custom_domain_dns_suffix
}


resource "azurerm_container_app_environment_dapr_component" "main" {
  for_each = { for c in var.dapr_components : c.name => c }

  container_app_environment_id = azurerm_container_app_environment.main.id

  name           = each.key
  component_type = each.value.component_type
  version        = each.value.version
  ignore_errors  = each.value.ignore_errors
  init_timeout   = each.value.init_timeout

  dynamic "metadata" {
    for_each = each.value.metadata
    content {
      name        = metadata.value.name
      secret_name = metadata.value.name
      value       = metadata.value.value
    }
  }

  scopes = each.value.scopes

  dynamic "secret" {
    for_each = each.value.secret
    content {
      name  = secret.value.name
      value = secret.value.value
    }
  }
}

resource "azurerm_container_app_environment_storage" "main" {
  for_each = { for s in var.storage : s.name => s }

  container_app_environment_id = azurerm_container_app_environment.main.id

  name         = each.key
  account_name = each.value.account_name
  share_name   = each.value.share_name
  access_key   = each.value.access_key
  access_mode  = each.value.access_mode
}
