# Diag settings / logs parameters

variable "logs_destinations_ids" {
  type        = list(string)
  nullable    = false
  description = <<EOD
List of destination resources IDs for logs diagnostic destination.
Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.
If you want to use Azure EventHub as a destination, you must provide a formatted string containing both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the <code>&#124;</code> character.
EOD
}

variable "logs_categories" {
  type        = list(string)
  description = "Log categories to send to destinations."
  default     = null
}

variable "logs_metrics_categories" {
  type        = list(string)
  description = "Metrics categories to send to destinations."
  default     = null
}

variable "diagnostic_settings_custom_name" {
  description = "Custom name of the diagnostics settings, name will be 'default' if not set."
  type        = string
  default     = "default"
}

variable "log_analytics_workspace" {
  description = <<EOD
Log Analytics Workspace receiving the Container Apps Environment console and system logs (`logs_destination = "log-analytics"`).
When `null`, `logs_destination` is `azure-monitor` if `logs_destinations_ids` is not empty (logs routed by the diagnostic settings), otherwise logs are only streamed.
Setting this workspace and also listing it in `logs_destinations_ids` sends the console logs twice (`ContainerAppConsoleLogs` table and diagnostic setting category).
EOD
  type = object({
    id = string
  })
  default = null
}
