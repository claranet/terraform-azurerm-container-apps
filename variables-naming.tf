# Generic naming variables
variable "name_prefix" {
  description = "Optional prefix for the generated name"
  type        = string
  default     = ""
}

variable "name_suffix" {
  description = "Optional suffix for the generated name"
  type        = string
  default     = ""
}

variable "use_caf_naming" {
  description = "Use the Azure CAF naming provider to generate default resource name. Both `aca_custom_name` & `aca_env_custom_name` override this if set. Legacy default name is used if this is set to `false`."
  type        = bool
  default     = true
}

# Custom naming override
variable "aca_custom_name" {
  description = "Custom Azure Container Apps, generated if not set"
  type        = string
  default     = ""
}

variable "aca_env_custom_name" {
  description = "Custom Azure Container Apps Environment, generated if not set"
  type        = string
  default     = ""
}
