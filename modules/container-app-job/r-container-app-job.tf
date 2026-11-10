resource "azurerm_container_app_job" "main" {
  name                         = local.name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  container_app_environment_id = var.container_app_environment_id
  workload_profile_name        = var.workload_profile_name

  replica_timeout_in_seconds = var.replica_timeout_in_seconds
  replica_retry_limit        = var.replica_retry_limit

  dynamic "manual_trigger_config" {
    for_each = var.manual_trigger_config[*]
    content {
      parallelism              = manual_trigger_config.value.parallelism
      replica_completion_count = manual_trigger_config.value.replica_completion_count
    }
  }

  dynamic "schedule_trigger_config" {
    for_each = var.schedule_trigger_config[*]
    content {
      cron_expression          = schedule_trigger_config.value.cron_expression
      parallelism              = schedule_trigger_config.value.parallelism
      replica_completion_count = schedule_trigger_config.value.replica_completion_count
    }
  }

  dynamic "event_trigger_config" {
    for_each = var.event_trigger_config[*]
    content {
      parallelism              = event_trigger_config.value.parallelism
      replica_completion_count = event_trigger_config.value.replica_completion_count

      dynamic "scale" {
        for_each = event_trigger_config.value.scale[*]
        content {
          max_executions              = scale.value.max_executions
          min_executions              = scale.value.min_executions
          polling_interval_in_seconds = scale.value.polling_interval_in_seconds

          dynamic "rules" {
            for_each = scale.value.rules
            content {
              name             = rules.value.name
              custom_rule_type = rules.value.custom_rule_type
              metadata         = rules.value.metadata
              identity_id      = rules.value.identity_id

              dynamic "authentication" {
                for_each = rules.value.authentications
                content {
                  secret_name       = authentication.value.secret_name
                  trigger_parameter = authentication.value.trigger_parameter
                }
              }
            }
          }
        }
      }
    }
  }

  template {

    dynamic "init_container" {
      for_each = var.init_containers
      content {
        args    = init_container.value.args
        command = init_container.value.command
        cpu     = init_container.value.cpu

        dynamic "env" {
          for_each = init_container.value.envs
          content {
            name        = env.value.name
            secret_name = env.value.secret_name
            value       = env.value.value
          }
        }

        image  = init_container.value.image
        memory = init_container.value.memory
        name   = init_container.value.name

        dynamic "volume_mounts" {
          for_each = init_container.value.volume_mnt
          content {
            name     = volume_mounts.value.name
            path     = volume_mounts.value.path
            sub_path = volume_mounts.value.sub_path
          }
        }
      }
    }

    dynamic "container" {
      for_each = var.containers
      content {
        args    = container.value.args
        command = container.value.command
        cpu     = container.value.cpu

        dynamic "env" {
          for_each = container.value.envs
          content {
            name        = env.value.name
            secret_name = env.value.secret_name
            value       = env.value.value
          }
        }

        image = container.value.image

        dynamic "liveness_probe" {
          for_each = container.value.liveness_probes
          content {
            failure_count_threshold = liveness_probe.value.failure_count_threshold

            dynamic "header" {
              for_each = liveness_probe.value.headers
              content {
                name  = header.value.name
                value = header.value.value
              }
            }

            host             = liveness_probe.value.host
            initial_delay    = liveness_probe.value.initial_delay
            interval_seconds = liveness_probe.value.interval_seconds
            path             = liveness_probe.value.transport == "TCP" ? null : liveness_probe.value.path
            port             = liveness_probe.value.port
            timeout          = liveness_probe.value.timeout
            transport        = liveness_probe.value.transport
          }
        }

        memory = container.value.memory
        name   = container.value.name

        dynamic "readiness_probe" {
          for_each = container.value.readiness_probes
          content {
            failure_count_threshold = readiness_probe.value.failure_count_threshold

            dynamic "header" {
              for_each = readiness_probe.value.headers
              content {
                name  = header.value.name
                value = header.value.value
              }
            }

            host                    = readiness_probe.value.host
            initial_delay           = readiness_probe.value.initial_delay
            interval_seconds        = readiness_probe.value.interval_seconds
            path                    = readiness_probe.value.transport == "TCP" ? null : readiness_probe.value.path
            port                    = readiness_probe.value.port
            success_count_threshold = readiness_probe.value.success_count_threshold
            timeout                 = readiness_probe.value.timeout
            transport               = readiness_probe.value.transport
          }
        }

        dynamic "startup_probe" {
          for_each = container.value.startup_probes
          content {
            failure_count_threshold = startup_probe.value.failure_count_threshold

            dynamic "header" {
              for_each = startup_probe.value.headers
              content {
                name  = header.value.name
                value = header.value.value
              }
            }

            host             = startup_probe.value.host
            initial_delay    = startup_probe.value.initial_delay
            interval_seconds = startup_probe.value.interval_seconds
            path             = startup_probe.value.transport == "TCP" ? null : startup_probe.value.path
            port             = startup_probe.value.port
            timeout          = startup_probe.value.timeout
            transport        = startup_probe.value.transport
          }
        }

        dynamic "volume_mounts" {
          for_each = container.value.volume_mnt
          content {
            name     = volume_mounts.value.name
            path     = volume_mounts.value.path
            sub_path = volume_mounts.value.sub_path
          }
        }
      }
    }

    dynamic "volume" {
      for_each = var.volumes
      content {
        name          = volume.value.name
        storage_name  = volume.value.storage_name
        storage_type  = volume.value.storage_type
        mount_options = volume.value.mount_options
      }
    }
  }

  dynamic "identity" {
    for_each = var.identity[*]
    content {
      type         = var.identity.type
      identity_ids = var.identity.identity_ids
    }
  }

  dynamic "registry" {
    for_each = var.registries
    content {
      server               = registry.value.server
      identity             = registry.value.identity
      password_secret_name = registry.value.password_secret_name
      username             = registry.value.username
    }
  }

  dynamic "secret" {
    for_each = var.secrets
    content {
      name                = secret.value.name
      identity            = secret.value.identity
      key_vault_secret_id = secret.value.key_vault_secret_id
      value               = secret.value.value
    }
  }

  tags = merge(local.default_tags, var.extra_tags)

  lifecycle {
    precondition {
      condition = length([
        for trigger in [var.manual_trigger_config, var.schedule_trigger_config, var.event_trigger_config] : trigger if trigger != null
      ]) == 1
      error_message = "Exactly one of `manual_trigger_config`, `schedule_trigger_config` and `event_trigger_config` must be set."
    }

    # azurecaf trims the name suffix first, then the other parts, when the name exceeds 32 characters:
    # jobs that differ only by their suffix would get the same name.
    precondition {
      condition     = (var.custom_name != null && var.custom_name != "") || data.azurecaf_name.acj.result == local.untrimmed_name
      error_message = "The generated Container App Job name `${local.untrimmed_name}` exceeds 32 characters and would be trimmed to `${coalesce(data.azurecaf_name.acj.result, "null")}`: set `custom_name`."
    }
  }
}
