resource "azurerm_container_app" "main" {
  name                         = local.name
  resource_group_name          = var.resource_group_name
  revision_mode                = var.revision_mode
  container_app_environment_id = var.container_app_environment_id

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

        ephemeral_storage = init_container.value.ephemeral_storage
        image             = init_container.value.image
        memory            = init_container.value.memory
        name              = init_container.value.name

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
            interval_seconds        = readiness_probe.value.interval_seconds
            path                    = readiness_probe.value.transport == "TCP" ? null : readiness_probe.value.port
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

    max_replicas = var.template_max_replicas
    min_replicas = var.template_min_replicas

    dynamic "azure_queue_scale_rule" {
      for_each = var.azure_queue_scale_rules

      content {
        name         = azure_queue_scale_rule.value.name
        queue_name   = azure_queue_scale_rule.value.queue_name
        queue_length = azure_queue_scale_rule.value.queue_length

        dynamic "authentication" {
          for_each = azure_queue_scale_rule.value.authentications
          content {
            secret_name       = authentication.value.secret_name
            trigger_parameter = authentication.value.trigger_parameter
          }
        }
      }
    }

    dynamic "custom_scale_rule" {

      for_each = var.custom_scale_rules

      content {
        name             = custom_scale_rule.value.name
        custom_rule_type = custom_scale_rule.value.custom_rule_type
        metadata         = custom_scale_rule.value.metadata

        dynamic "authentication" {
          for_each = custom_scale_rule.value.authentications
          content {
            secret_name       = authentication.value.secret_name
            trigger_parameter = authentication.value.trigger_parameter
          }
        }
      }
    }

    dynamic "http_scale_rule" {

      for_each = var.http_scale_rules

      content {
        name                = http_scale_rule.value.name
        concurrent_requests = http_scale_rule.value.concurrent_requests

        dynamic "authentication" {
          for_each = http_scale_rule.value.authentications
          content {
            secret_name       = authentication.value.secret_name
            trigger_parameter = authentication.value.trigger_parameter
          }
        }
      }
    }

    dynamic "tcp_scale_rule" {

      for_each = var.tcp_scale_rules
      content {
        name                = tcp_scale_rule.value.name
        concurrent_requests = tcp_scale_rule.value.concurrent_requests

        dynamic "authentication" {
          for_each = tcp_scale_rule.value.authentications
          content {
            secret_name       = authentication.value.secret_name
            trigger_parameter = authentication.value.trigger_parameter
          }
        }
      }
    }

    revision_suffix                  = var.revision_suffix
    termination_grace_period_seconds = var.termination_grace_period_seconds

    dynamic "volume" {
      for_each = var.volumes
      content {
        name         = volume.value.name
        storage_name = volume.value.storage_name
        storage_type = volume.value.storage_type
      }
    }
  }

  dynamic "dapr" {
    for_each = var.daprs
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
    for_each = var.ingresses

    content {

      allow_insecure_connections = ingress.value.allow_insecure_connections
      client_certificate_mode    = ingress.value.client_certificate_mode

      dynamic "cors" {
        for_each = ingress.value.cors[*]
        content {
          allowed_origins           = cors.value.allowed_origins
          allowed_methods           = cors.value.allowed_methods
          allowed_headers           = cors.value.allowed_headers
          exposed_headers           = cors.value.exposed_headers
          max_age_in_seconds        = cors.value.max_age_in_seconds
          allow_credentials_enabled = cors.value.allow_credentials_enabled
        }
      }

      dynamic "custom_domain" {
        for_each = ingress.value.custom_domains
        content {
          certificate_binding_type = custom_domain.value.certificate_binding_type
          certificate_id           = custom_domain.value.certificate_id
          name                     = custom_domain.value.name
        }
      }

      exposed_port     = ingress.value.exposed_port
      external_enabled = ingress.value.external_enabled

      dynamic "ip_security_restriction" {
        for_each = ingress.value.ip_security_restrictions
        content {
          action           = ip_security_restriction.value.action
          description      = ip_security_restriction.value.description
          ip_address_range = ip_security_restriction.value.ip_address_range
          name             = ip_security_restriction.value.name
        }
      }

      target_port = ingress.value.target_port

      dynamic "traffic_weight" {
        for_each = ingress.value.traffic_weights
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

  workload_profile_name  = var.workload_profile_name
  max_inactive_revisions = var.max_inactive_revisions

  tags = merge(local.default_tags, var.extra_tags)
}
