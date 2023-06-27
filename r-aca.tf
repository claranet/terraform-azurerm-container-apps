resource "azurerm_container_app_environment" "aca_env" {
  name                       = local.aca_env_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  log_analytics_workspace_id = module.aca_logs.log_analytics_workspace_id
}

resource "azurerm_container_app" "aca" {
  name = local.aca_name

  resource_group_name = var.resource_group_name

  revision_mode = var.revision_mode

  container_app_environment_id = azurerm_container_app_environment.aca_env.id

  template {

    dynamic "container" {
      for_each = var.container_configuration

      content {
        name    = lookup(container.value, "name")
        image   = lookup(container.value, "image")
        cpu     = lookup(container.value, "cpu")
        memory  = lookup(container.value, "memory")
        args    = lookup(container.value, "args", null)
        command = lookup(container.value, "command", null)

        dynamic "env" {
          for_each = container.value.env_configuration != null ? container.value.env_configuration : []

          content {
            name        = env.value.name
            secret_name = env.value.name
            value       = value.value.name
          }
        }

        dynamic "liveness_probe" {
          for_each = container.value.liveness_probe_configuration != null ? container.value.liveness_probe_configuration : []

          content {
            failure_count_threshold = liveness_probe.value.failure_count_threshold

            dynamic "header" {
              for_each = liveness_probe.value.header_configuration != null ? liveness_probe.value.header_configuration : []

              content {
                name  = header.value.name
                value = header.value.value
              }
            }

            host                             = liveness_probe.value.host
            initial_delay                    = liveness_probe.value.initial_delay
            interval_seconds                 = liveness_probe.value.interval_seconds
            path                             = liveness_probe.value.path
            termination_grace_period_seconds = liveness_probe.value.termination_grace_period_seconds
            timeout                          = liveness_probe.value.timeout
            transport                        = liveness_probe.value.transport
            port                             = liveness_probe.value.port
          }
        }

        dynamic "readiness_probe" {
          for_each = container.value.readiness_probe_configuration != null ? container.value.readiness_probe_configuration : []

          content {

            dynamic "header" {
              for_each = readiness_probe.value.header_configuration != null ? readiness_probe.value.header_configuration : []

              content {
                name  = header.value.name
                value = header.value.value
              }
            }

            port      = readiness_probe.value.port
            transport = readiness_probe.value.transport
          }
        }

        dynamic "startup_probe" {
          for_each = container.value.startup_probe_configuration != null ? container.value.startup_probe_configuration : []

          content {

            dynamic "header" {
              for_each = startup_probe.value.header_configuration != null ? startup_probe.value.header_configuration : []

              content {
                name  = header.value.name
                value = header.value.value
              }
            }

            port      = startup_probe.value.port
            transport = startup_probe.value.transport
          }
        }

        dynamic "volume_mounts" {
          for_each = container.value.volume_mounts_configuration != null ? container.value.volume_mounts_configuration : []

          content {
            name = volume_mounts.value.name
            path = volume_mounts.value.path
          }
        }
      }

      # max_replicas    = var.template_max_replicas
      # min_replicas    = var.template_min_replicas
      # revision_suffix = var.template_revision_suffix

      # volume {
      #   name = var.template_volume_name
      #   storage_name = var.template_volume_storage_name
      #   storage_type = var.template_storage_type
      # }

    }




    # volume {
    #   name         = var.container_volume_name
    #   storage_name = var.container_volume_storage_name
    #   storage_type = var.container_volume_storage_type
    # }
  }

  tags = merge(local.default_tags, var.extra_tags)
}
