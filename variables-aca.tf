variable "containers" {
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
    envs = optional(list(object({
      name        = optional(string, null)
      secret_name = optional(string, null)
      value       = optional(string, null)
    })))
    liveness_probes = optional(list(object({
      failure_count_threshold = optional(number, 3)
      headers = optional(list(object({
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
    readiness_probes = optional(list(object({
      failure_count_threshold = optional(number, 3)
      headers = optional(list(object({
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
    startup_probes = optional(list(object({
      failure_count_threshold = optional(number, 3)
      headers = optional(list(object({
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
    volume_mnt = optional(list(object({
      name = optional(string, null)
      path = optional(string, null)
    })))
  }))
  default = []
}

variable "daprs" {
  description = <<EOD
A `dapr` object with following attributes:
```
- name:                           xxxxxxxxxxxxxx
```
EOD
  type = list(object({
    app_id       = string
    app_port     = optional(number)
    app_protocol = optional(string, "http")
  }))
  default = []
}

variable "ingresses" {
  description = <<EOD
An `ingress` object with following attributes:
```
- name:                           xxxxxxxxxxxxxx
```
EOD
  type = list(object({

  }))
  default = []
}

variable "registries" {
  description = <<EOD
A `registry` object with following attributes:
```
- name:                           xxxxxxxxxxxxxx
```
EOD
  type = list(object({
    allow_insecure_connections = bool
    custom_domain = optional(list(object({
      certificate_binding_type = optional(string, "Disabled")
      certificate_id           = string
      name                     = string
    })))
    fqdn             = optional(string)
    external_enabled = optional(bool)
    target_port      = number
    traffic_weight = list(object({
      label           = optional(string)
      latest_revision = optional(string)
      revision_suffix = optional(string)
      percentage      = number
    }))
    transport = optional(string, "auto")
  }))
  default = []
}

variable "secrets" {
  description = <<EOD
Secret configuration object with following attributes:
```
Secrets cannot be removed from the service once added, attempting to do so will result in an error.
Their values may be zeroed, i.e. set to `""`, but the named secret must persist.
- name: The secret name.
- value: The value for this secret.
```
EOD
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}
