variable "container_app_environment_id" {
  description = "ID of the Container App Environment in which to create the Container App Job."
  type        = string
}

variable "workload_profile_name" {
  description = "Name of the Workload Profile of the Container App Environment used by the Container App Job."
  type        = string
  default     = null
}

variable "replica_timeout_in_seconds" {
  description = "Maximum number of seconds a replica is allowed to run."
  type        = number
  default     = 1800
  nullable    = false
}

variable "replica_retry_limit" {
  description = "Maximum number of times a replica is allowed to retry."
  type        = number
  default     = null
}

variable "manual_trigger_config" {
  description = "Manual trigger of the Container App Job, started on demand. Exactly one of `manual_trigger_config`, `schedule_trigger_config` and `event_trigger_config` must be set."
  type = object({
    parallelism              = optional(number, 1)
    replica_completion_count = optional(number, 1)
  })
  default = null
}

variable "schedule_trigger_config" {
  description = "Schedule trigger of the Container App Job. `cron_expression` is evaluated in UTC. Exactly one of `manual_trigger_config`, `schedule_trigger_config` and `event_trigger_config` must be set."
  type = object({
    cron_expression          = string
    parallelism              = optional(number, 1)
    replica_completion_count = optional(number, 1)
  })
  default = null
}

variable "event_trigger_config" {
  description = "Event trigger of the Container App Job, with its KEDA scale rules. Exactly one of `manual_trigger_config`, `schedule_trigger_config` and `event_trigger_config` must be set."
  type = object({
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
  })
  default = null
}

variable "init_containers" {
  description = "Configuration of one or more init containers."
  type = list(object({
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
  }))
  default = []
}

variable "containers" {
  description = "Configuration of one or more containers."
  type = list(object({
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
}

variable "volumes" {
  description = "Parameters used to define one or more `volume` object. With `storage_type = \"Secret\"`, the secrets of the Container App Job are mounted as files."
  type = list(object({
    name          = string
    storage_name  = optional(string)
    storage_type  = optional(string, "EmptyDir")
    mount_options = optional(string)
  }))
  default = []
}

variable "identity" {
  description = "Map with identity block information. Set to `null` to create the Container App Job without identity."
  type = object({
    type         = string
    identity_ids = list(string)
  })
  default = {
    type         = "SystemAssigned"
    identity_ids = []
  }
}

variable "registries" {
  description = "Parameters used to define one or more `registry` object."
  type = list(object({
    server               = string
    identity             = optional(string)
    password_secret_name = optional(string)
    username             = optional(string)
  }))
  default = []
}

variable "secrets" {
  description = "Parameters used to define one or more `secret` object."
  type = list(object({
    name                = string
    identity            = optional(string)
    key_vault_secret_id = optional(string)
    value               = optional(string)
  }))
  default = []
}
