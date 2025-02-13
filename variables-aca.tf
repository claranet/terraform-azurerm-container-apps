variable "init_containers" {
  description = "The name of the Container App. Changing this forces a new resource to be created."
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
    ephemeral_storage = optional(string, null)
    volume_mnt = optional(list(object({
      name = string
      path = string
    })), [])
  }))
  default = []
}

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

variable "template_max_replicas" {
  description = "The maximum number of replicas for this container."
  type        = number
  default     = null
}

variable "template_min_replicas" {
  description = "The minimum number of replicas for this container."
  type        = number
  default     = null
}

variable "azure_queue_scale_rules" {
  description = <<EOD
One or more `azure_queue_scale_rule` object with following attributes:
```
- name:                           xxxxxxxxxxxxxx
```
EOD
  type = list(object({
    name         = string
    queue_name   = string
    queue_length = string
    authentications = list(object({
      secret_name       = string
      trigger_parameter = string
    }))
  }))
  default = []
}

variable "custom_scale_rules" {
  description = <<EOD
One or more `custom_scale_rule` object with following attributes:
```
- name:                           xxxxxxxxxxxxxx
```
EOD
  type = list(object({
    name             = string
    custom_rule_type = string
    metadata         = map(string)
    authentications = optional(list(object({
      secret_name       = string
      trigger_parameter = string
    })), [])
  }))
  default = []
}

variable "http_scale_rules" {
  description = <<EOD
One or more `http_scale_rule` object with following attributes:
```
- name:                           xxxxxxxxxxxxxx
```
EOD
  type = list(object({
    name                = string
    concurrent_requests = number
    authentications = optional(list(object({
      secret_name       = string
      trigger_parameter = string
    })), [])
  }))
  default = []
}

variable "tcp_scale_rules" {
  description = <<EOD
One or more `tcp_scale_rule` object with following attributes:
```
- name:                           xxxxxxxxxxxxxx
```
EOD
  type = list(object({
    name                = string
    concurrent_requests = number
    authentications = optional(list(object({
      secret_name       = string
      trigger_parameter = string
    })), [])
  }))
  default = []
}

variable "revision_suffix" {
  description = "The suffix for the revision. This value must be unique for the lifetime of the Resource. If omitted the service will use a hash function to create one."
  type        = string
  default     = ""
}

variable "termination_grace_period_seconds" {
  description = "The time in seconds after the container is sent the termination signal before the process if forcibly killed."
  type        = number
  default     = null
}

variable "volumes" {
  description = <<EOD
A `tcp_scale_rule` object with following attributes:
```
- name:                           xxxxxxxxxxxxxx
```
EOD
  type = list(object({
    name         = string
    storage_name = optional(string)
    storage_type = optional(string, "EmptyDir")
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

variable "identity" {
  description = "Map with identity block information."
  type = object({
    type         = string
    identity_ids = list(string)
  })
  default = {
    type         = "SystemAssigned"
    identity_ids = []
  }
}

variable "ingresses" {
  description = <<EOD
An `ingress` object with following attributes:
```
- name:                           xxxxxxxxxxxxxx
```
EOD
  type = list(object({
    allow_insecure_connections = optional(bool, false)
    external_enabled           = optional(bool, false)
    ip_security_restrictions = optional(list(object({
      action           = string
      description      = optional(string)
      ip_address_range = string
      name             = string
    })), [])
    target_port  = number
    exposed_port = optional(number)
    traffic_weights = list(object({
      label           = optional(string)
      latest_revision = optional(string)
      revision_suffix = optional(string)
      percentage      = number
    }))
    transport = optional(string, "auto")
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
    server               = string
    identity             = optional(string)
    password_secret_name = optional(string)
    username             = optional(string)
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

variable "workload_profile_name" {
  description = "The name of the Workload Profile in the Container App Environment to place this Container App."
  type        = string
  default     = "Consumption"
}

variable "max_inactive_revisions" {
  description = "The maximum of inactive revisions allowed for this Container App."
  type        = number
  default     = null
}
