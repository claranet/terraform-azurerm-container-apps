variable "container_app_environment_id" {
  description = "The ID of the Container App Environment within which this Container App should exist. Changing this forces a new resource to be created."
  type        = string
}

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

variable "azure_queue_scale_rule_configuration" {
  description = <<EOD
One or more `azure_queue_scale_rule` object with following attributes:
```
- name:                           xxxxxxxxxxxxxx
```
EOD
  type = list(object({
    name         = string
    queue_name   = string
    queue_lenght = string
    authentication = list(object({
      secret_name       = string
      trigger_parameter = string
    }))
  }))
  default = []
}

variable "custom_scale_rule_configuration" {
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
    authentication = optional(list(object({
      secret_name       = string
      trigger_parameter = string
    })))
  }))
  default = []
}

variable "http_scale_rule_configuration" {
  description = <<EOD
One or more `http_scale_rule` object with following attributes:
```
- name:                           xxxxxxxxxxxxxx
```
EOD
  type = list(object({
    name                = string
    concurrent_requests = number
    authentication = optional(list(object({
      secret_name       = string
      trigger_parameter = string
    })))
  }))
  default = []
}

variable "tcp_scale_rule_configuration" {
  description = <<EOD
One or more `tcp_scale_rule` object with following attributes:
```
- name:                           xxxxxxxxxxxxxx
```
EOD
  type = list(object({
    name                = string
    concurrent_requests = number
    authentication = optional(list(object({
      secret_name       = string
      trigger_parameter = string
    })))
  }))
  default = []
}

variable "template_revision_suffix" {
  description = "The suffix for the revision. This value must be unique for the lifetime of the Resource. If omitted the service will use a hash function to create one."
  type        = string
  default     = ""
}

variable "volume_configuration" {
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

variable "dapr_configuration" {
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

variable "ingress_configuration" {
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

variable "registry_configuration" {
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

variable "secret_configuration" {
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
