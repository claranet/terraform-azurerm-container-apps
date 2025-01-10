variable "dapr_application_insights_connection_string" {
  description = "Application Insights connection string used by Dapr to export Service to Service communication telemetry."
  type        = string
  default     = null
}

# variable "infrastructure_subnet_id" {
#   description = "The existing Subnet to use for the Container Apps Control Plane. Changing this forces a new resource to be created. "
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
  description = "The ID for the Log Analytics Workspace to link this Container Apps Managed Environment to. Changing this forces a new resource to be created."
  type        = string
  default     = null
}
