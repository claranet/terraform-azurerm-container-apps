
variable "dapr_application_insights_connection_string" {
  description = "Application Insights connection string used by Dapr to export Service to Service communication telemetry. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "infrastructure_resource_group_name" {
  description = "Name of the platform-managed resource group created for the Managed Environment to host infrastructure resources. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

# variable "infrastructure_subnet_id" {
#   description = "The existing Subnet to use for the Container Apps Control Plane. Changing this forces a new resource to be created. The Subnet must have a `/21` or larger address space."
#   type        = string
#   default     = null
# }

# variable "internal_load_balancer_enabled" {
#   description = "Should the Container Environment operate in Internal Load Balancing Mode? Defaults to `false`. Changing this forces a new resource to be created."
#   type        = bool
#   default     = false
# }

# variable "zone_redundancy_enabled" {
#   description = "Should the Container App Environment be created with Zone Redundancy enabled? Defaults to `false`. Changing this forces a new resource to be created."
#   type        = bool
#   default     = false
# }

variable "log_analytics_workspace_id" {
  description = "The ID for the Log Analytics Workspace to link this Container Apps Managed Environment to."
  type        = string
  default     = null
}

variable "workload_profile" {
  description = <<EOD
The profile of the workload to scope the container app execution. A `workload_profile` block as defined below.
  ```
- name                  : The name of the workload profile
- workload_profile_type : Workload profile type for the workloads to run on. Possible values include `Consumption`, `D4`, `D8`, `D16`, `D32`, `E4`, `E8`, `E16` and `E32`.
- maximum_count         : The maximum number of instances of workload profile that can be deployed in the Container App Environment.
- minimum_count         : The minimum number of instances of workload profile that can be deployed in the Container App Environment.
```
EOD
  type = map(object({
    name                  = string
    workload_profile_type = optional(string, "Consumption")
    maximum_count         = number
    minimum_count         = number
  }))
  validation {
    condition     = alltrue([for m in var.workload_profile : contains(["Consumption", "D4", "D8", "D16", "D32", "E4", "E8", "E16", "E32"], m.workload_profile_type)])
    error_message = "The `workload_profile_type` attribute of `var.workload_profile` object list must be `Consumption`, `D4`, `D8`, `D16`, `D32`, `E4`, `E8`, `E16` or `E32`."
  }
  default = {}
}

variable "mutual_tls_enabled" {
  description = "Should mutual transport layer security (mTLS) be enabled? Defaults to `false`."
  type        = bool
  default     = false
}

variable "certificate" {
  description = "Container App Environment Certificate parameters."
  type = list(object({
    name                    = string
    certificate_blob_base64 = string
    certificate_password    = string
  }))
  default = []
}

variable "custom_domain_enabled" {
  description = "Should the Container App Environment be configured with a Custom Domain? Defaults to `false`."
  type        = bool
  default     = false
}

variable "custom_domain_certificate_blob_base64" {
  description = "The bundle of Private Key and Certificate for the Custom DNS Suffix as a base64 encoded PFX or PEM."
  type        = string
  default     = ""
}

variable "custom_domain_certificate_password" {
  description = "The password for the Certificate bundle."
  type        = string
  default     = ""
}

variable "custom_domain_dns_suffix" {
  description = "Custom DNS Suffix for the Container App Environment."
  type        = string
  default     = ""
}

variable "dapr_components" {
  description = "Dapr Components to be added to the Container App Environment."
  type = list(object({
    name           = string
    component_type = string
    version        = string
    ignore_errors  = optional(bool, false)
    init_timeout   = optional(string, "5s")
    metadata = list(object({
      name        = string
      value       = optional(string)
      secret_name = optional(string)
    }))
    scopes = list(string)
    secrets = list(object({
      name  = string
      value = string
    }))
  }))
  default = []
}

variable "storage" {
  description = "Storage parameters for the Container App Environment."
  type = list(object({
    name         = string
    account_name = string
    access_key   = string
    share_name   = string
    access_mode  = optional(string, "ReadWrite")
  }))
  validation {
    condition     = alltrue([for m in var.storage : contains(["ReadWrite", "ReadOnly"], m.access_mode)])
    error_message = "The `access_mode` attribute of `var.storage` object list must be `ReadWrite` or `ReadOnly`."
  }
  default = []
}
