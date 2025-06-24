variable "revision_mode" {
  type        = string
  description = "The revisions operational mode for the Container App. Possible values include `Single` and `Multiple`. In `Single` mode, a single revision is in operation at any given time. In `Multiple` mode, more than one revision can be active at a time and can be configured with load distribution via the `traffic_weight` block in the `ingress` configuration."
  default     = "Single"
}

variable "init_containers" {
  description = "Configuration of an init containers."
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
      transport        = optional(string, null)
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
      transport               = optional(string, null)
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
      transport        = optional(string, null)
    })), [])
    volume_mnt = optional(list(object({
      name = string
      path = string
    })), [])
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
  description = "Parameters used to define one or more`azure_queue_scale_rule` object"
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
  description = "Parameters used to define one or more `custom_scale_rule` object"
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
  description = "Parameters used to define one or more `http_scale_rule` object"
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
  description = "Parameters used to define one or more `tcp_scale_rule` object"
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
  description = "Parameters used to define one or more `volume` object"
  type = list(object({
    name         = string
    storage_name = optional(string)
    storage_type = optional(string, "EmptyDir")
  }))
  default = []
}

variable "daprs" {
  description = "Parameters used to define one or more `dapr` object"
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
  description = "Parameters used to define one or more `ingress` object"
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
  description = "Parameters used to define one or more `registry` object"
  type = list(object({
    server               = string
    identity             = optional(string)
    password_secret_name = optional(string)
    username             = optional(string)
  }))
  default = []
}

variable "secrets" {
  description = "Parameters used to define one or more `secret` object"
  type = list(object({
    name                = string
    identity            = optional(string)
    key_vault_secret_id = optional(string)
    value               = optional(string)
  }))
  default = []
}

variable "workload_profile_name" {
  description = "The name of the Workload Profile in the Container App Environment to place this Container App."
  type        = string
  default     = null
}

variable "max_inactive_revisions" {
  description = "The maximum of inactive revisions allowed for this Container App."
  type        = number
  default     = null
}
