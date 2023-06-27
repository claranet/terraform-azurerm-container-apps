variable "revision_mode" {
  type        = string
  description = "The revisions operational mode for the Container App. Possible values include `Single` and `Multiple`. In `Single` mode, a single revision is in operation at any given time. In `Multiple` mode, more than one revision can be active at a time and can be configured with load distribution via the `traffic_weight` block in the `ingress` configuration."
  default     = "Single"
}

variable "container_configuration" {
  description = <<EOD
Container configuration object with following attributes:
```
- name:                           xxxxxxxxxxxxxx
```
EOD
  type = list(object({
    name    = string
    image   = string
    cpu     = number
    memory  = string
    args    = optional(list(string), null)
    command = optional(list(string), null)
    env_configuration = optional(list(object({
      name        = optional(string, null)
      secret_name = optional(string, null)
      value       = optional(string, null)
    })))
    liveness_probe_configuration = optional(list(object({
      failure_count_threshold = optional(number, 3)
      header_configuration = optional(list(object({
        name  = optional(string)
        value = optional(string)
      })))
      host                    = optional(string)
      initial_delay           = optional(number)
      interval_seconds        = optional(number, 10)
      path                    = optional(string, "/")
      port                    = optional(number)
      success_count_threshold = optional(number, 3)
      timeout                 = optional(number, 1)
      transport               = optional(string)
    })))
    readiness_probe_configuration = optional(list(object({
      failure_count_threshold = optional(number, 3)
      header_configuration = optional(list(object({
        name  = optional(string)
        value = optional(string)
      })))
      host                             = optional(string)
      interval_seconds                 = optional(number, 10)
      path                             = optional(string, "/")
      port                             = optional(number)
      termination_grace_period_seconds = optional(number)
      timeout                          = optional(number, 1)
      transport                        = optional(string)
    })))
    startup_probe_configuration = optional(list(object({
      failure_count_threshold = optional(number, 3)
      header_configuration = optional(list(object({
        name  = optional(string)
        value = optional(string)
      })))
      host                             = optional(string)
      interval_seconds                 = optional(number, 10)
      path                             = optional(string, "/")
      port                             = optional(number)
      termination_grace_period_seconds = optional(number)
      timeout                          = optional(number, 1)
      transport                        = optional(string)
    })))
    volume_mounts_configuration = optional(list(object({
      name = optional(string, null)
      path = optional(string, null)
    })))
  }))
  default = []
}
