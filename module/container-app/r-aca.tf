resource "azurerm_container_app" "aca" {
  name                         = local.name
  resource_group_name          = var.resource_group_name
  revision_mode                = var.revision_mode
  container_app_environment_id = var.container_app_environment_id

  template {

    dynamic "container" {
      for_each = var.container_configuration
      content {
        args    = lookup(container.value, "args", null)
        command = lookup(container.value, "command", null)
        cpu     = lookup(container.value, "cpu", "0.25")

        dynamic "env" {
          for_each = container.value.env_configuration != null ? container.value.env_configuration : []
          content {
            name        = env.value.name
            secret_name = env.value.secret_name
            value       = env.value.value
          }
        }

        image = lookup(container.value, "image", null)

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
            port                             = liveness_probe.value.port
            termination_grace_period_seconds = liveness_probe.value.termination_grace_period_seconds
            timeout                          = liveness_probe.value.timeout
            transport                        = liveness_probe.value.transport
          }
        }

        memory = lookup(container.value, "memory", "0.5Gi")
        name   = lookup(container.value, "name", null)

        dynamic "readiness_probe" {
          for_each = container.value.readiness_probe_configuration != null ? container.value.readiness_probe_configuration : []
          content {
            failure_count_threshold = readiness_probe.value.failure_count_threshold

            dynamic "header" {
              for_each = readiness_probe.value.header_configuration != null ? readiness_probe.value.header_configuration : []
              content {
                name  = header.value.name
                value = header.value.value
              }
            }

            host                    = readiness_probe.value.host
            interval_seconds        = readiness_probe.value.interval_seconds
            path                    = readiness_probe.value.path
            port                    = readiness_probe.value.port
            success_count_threshold = readiness_probe.value.success_count_threshold
            timeout                 = readiness_probe.value.timeout
            transport               = readiness_probe.value.transport
          }
        }

        dynamic "startup_probe" {
          for_each = container.value.startup_probe_configuration != null ? container.value.startup_probe_configuration : []
          content {
            failure_count_threshold = startup_probe.value.failure_count_threshold

            dynamic "header" {
              for_each = startup_probe.value.header_configuration != null ? startup_probe.value.header_configuration : []
              content {
                name  = header.value.name
                value = header.value.value
              }
            }

            host                             = startup_probe.value.host
            interval_seconds                 = startup_probe.value.interval_seconds
            path                             = startup_probe.value.path
            port                             = startup_probe.value.port
            termination_grace_period_seconds = startup_probe.value.termination_grace_period_seconds
            timeout                          = startup_probe.value.timeout
            transport                        = startup_probe.value.transport
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
    }

    max_replicas = var.template_max_replicas
    min_replicas = var.template_min_replicas

    dynamic "azure_queue_scale_rule" {
      for_each = var.azure_queue_scale_rule_configuration

      content {
        name         = azure_queue_scale_rule.value.name
        queue_name   = azure_queue_scale_rule.value.queue_name
        queue_length = azure_queue_scale_rule.value.queue_length

        dynamic "authentication" {
          for_each = azure_queue_scale_rule.value.authentication_configuration != null ? azure_queue_scale_rule.value.authentication_configuration : []
          content {
            secret_name       = authentication.value.secret_name
            trigger_parameter = authentication.value.trigger_parameter
          }
        }
      }
    }

    dynamic "custom_scale_rule" {

      for_each = var.custom_scale_rule_configuration

      content {
        name             = custom_scale_rule.value.name
        custom_rule_type = custom_scale_rule.value.custom_rule_type
        metadata         = custom_scale_rule.value.metada

        dynamic "authentication" {
          for_each = custom_scale_rule.value.authentication_configuration != null ? custom_scale_rule.value.authentication_configuration : []
          content {
            secret_name       = authentication.value.secret_name
            trigger_parameter = authentication.value.trigger_parameter
          }
        }
      }
    }

    dynamic "http_scale_rule" {

      for_each = var.http_scale_rule_configuration

      content {
        name                = http_scale_rule.value.name
        concurrent_requests = http_scale_rule.value.concurrent_requests

        dynamic "authentication" {
          for_each = http_scale_rule.value.authentication_configuration != null ? http_scale_rule.value.authentication_configuration : []
          content {
            secret_name       = authentication.value.secret_name
            trigger_parameter = authentication.value.trigger_parameter
          }
        }
      }
    }

    dynamic "tcp_scale_rule" {

      for_each = var.tcp_scale_rule_configuration
      content {
        name                = tcp_scale_rule.value.name
        concurrent_requests = tcp_scale_rule.value.concurrent_requests

        dynamic "authentication" {
          for_each = tcp_scale_rule.value.authentication_configuration != null ? tcp_scale_rule.value.authentication_configuration : []
          content {
            secret_name       = authentication.value.secret_name
            trigger_parameter = authentication.value.trigger_parameter
          }
        }
      }
    }

    revision_suffix = var.template_revision_suffix

    dynamic "volume" {
      for_each = var.volume_configuration
      content {
        name         = volume.value.template_volume_name
        storage_name = volume.value.template_volume_storage_name
        storage_type = volume.value.template_storage_type
      }
    }
  }

  dynamic "dapr" {
    for_each = var.dapr_configuration
    content {
      app_id       = dapr.value.app_id
      app_port     = dapr.value.app_port
      app_protocol = dapr.value.app_protocol
    }
  }

  dynamic "identity" {
    for_each = var.identity[*]
    content {
      type         = var.identity.type
      identity_ids = var.identity.identity_ids
    }
  }

  dynamic "ingress" {
    for_each = var.ingress_configuration

    content {

      allow_insecure_connections = ingress.value.allow_insecure_connections

      dynamic "custom_domain" {
        for_each = ingress.value.custom_domain_configuration != null ? ingress.value.custom_domain_configuration : []
        content {
          name                     = custom_domain.value.name
          certificate_id           = custom_domain.value.certificate_id
          certificate_binding_type = custom_domain.value.certificate_binding_type
        }
      }

      fqdn             = ingress.value.fqdn
      external_enabled = ingress.value.external_enabled
      target_port      = ingress.value.target_port

      dynamic "traffic_weight" {
        for_each = ingress.value.traffic_weight_configuration
        content {
          label           = traffic_weight.value.label
          latest_revision = traffic_weight.value.latest_revision
          revision_suffix = traffic_weight.value.revision_suffix
          percentage      = traffic_weight.value.percentage
        }
      }

      transport = ingress.value.transport
    }
  }

  dynamic "registry" {
    for_each = var.registry_configuration
    content {
      server               = registry.value.server
      identity             = registry.value.identity
      username             = registry.value.username
      password_secret_name = registry.value.password_secret_name
    }
  }

  dynamic "secret" {
    for_each = var.secret_configuration
    content {
      name  = secret.value.name
      value = secret.value.value
    }
  }

  tags = merge(local.default_tags, var.extra_tags)
}
