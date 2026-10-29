variable "container_app_jobs" {
  description = <<EOD
Container App Jobs to create in the Container App Environment, by key. The key is added to the name suffix of the job:
set `custom_name` when generated names would exceed 32 characters. Exactly one trigger per job.
Attributes are described in [`./modules/container-app-job/README.md`](./modules/container-app-job/README.md).
EOD
  type = map(object({
    custom_name                = optional(string, "")
    workload_profile_name      = optional(string)
    replica_timeout_in_seconds = optional(number, 1800)
    replica_retry_limit        = optional(number)
    manual_trigger_config = optional(object({
      parallelism              = optional(number, 1)
      replica_completion_count = optional(number, 1)
    }))
    schedule_trigger_config = optional(object({
      cron_expression          = string
      parallelism              = optional(number, 1)
      replica_completion_count = optional(number, 1)
    }))
    event_trigger_config = optional(object({
      parallelism              = optional(number, 1)
      replica_completion_count = optional(number, 1)
      scale = optional(object({
        max_executions              = optional(number, 100)
        min_executions              = optional(number, 0)
        polling_interval_in_seconds = optional(number, 30)
        rules = optional(list(object({
          name             = string
          custom_rule_type = string
          metadata         = map(string)
          identity_id      = optional(string)
          authentications = optional(list(object({
            secret_name       = string
            trigger_parameter = string
          })), [])
        })), [])
      }))
    }))
    init_containers = optional(list(object({
      name    = string
      args    = optional(list(string), null)
      command = optional(list(string), null)
      cpu     = optional(number, null)
      image   = string
      memory  = optional(string, null)
      envs = optional(list(object({
        name        = string
        secret_name = optional(string, null)
        value       = optional(string, null)
      })), [])
      volume_mnt = optional(list(object({
        name     = string
        path     = string
        sub_path = optional(string, null)
      })), [])
    })), [])
    containers = list(object({
      name    = string
      image   = string
      cpu     = number
      memory  = string
      args    = optional(list(string), null)
      command = optional(list(string), null)
      envs = optional(list(object({
        name        = string
        secret_name = optional(string, null)
        value       = optional(string, null)
      })), [])
      liveness_probes = optional(list(object({
        failure_count_threshold = optional(number, 3)
        headers = optional(list(object({
          name  = string
          value = string
        })), [])
        host             = optional(string, null)
        initial_delay    = optional(number, 1)
        interval_seconds = optional(number, 10)
        path             = optional(string, "/")
        port             = number
        timeout          = optional(number, 1)
        transport        = optional(string, "HTTP")
      })), [])
      readiness_probes = optional(list(object({
        failure_count_threshold = optional(number, 3)
        headers = optional(list(object({
          name  = string
          value = string
        })), [])
        host                    = optional(string, null)
        initial_delay           = optional(number, 0)
        interval_seconds        = optional(number, 10)
        path                    = optional(string, "/")
        port                    = number
        success_count_threshold = optional(number, 3)
        timeout                 = optional(number, 1)
        transport               = optional(string, "HTTP")
      })), [])
      startup_probes = optional(list(object({
        failure_count_threshold = optional(number, 3)
        headers = optional(list(object({
          name  = string
          value = string
        })), [])
        host             = optional(string, null)
        initial_delay    = optional(number, 0)
        interval_seconds = optional(number, 10)
        path             = optional(string, "/")
        port             = number
        timeout          = optional(number, 1)
        transport        = optional(string, "HTTP")
      })), [])
      volume_mnt = optional(list(object({
        name     = string
        path     = string
        sub_path = optional(string, null)
      })), [])
    }))
    volumes = optional(list(object({
      name          = string
      storage_name  = optional(string)
      storage_type  = optional(string, "EmptyDir")
      mount_options = optional(string)
    })), [])
    identity = optional(object({
      type         = string
      identity_ids = list(string)
      }), {
      type         = "SystemAssigned"
      identity_ids = []
    })
    registries = optional(list(object({
      server               = string
      identity             = optional(string)
      password_secret_name = optional(string)
      username             = optional(string)
    })), [])
    secrets = optional(list(object({
      name                = string
      identity            = optional(string)
      key_vault_secret_id = optional(string)
      value               = optional(string)
    })), [])
  }))
  default  = {}
  nullable = false
}
