variable "name_prefix" {
  description = "Optional prefix for the generated name."
  type        = string
  default     = ""
}

variable "name_suffix" {
  description = "Optional suffix for the generated name."
  type        = string
  default     = ""
}

# Custom naming override
variable "aca_env_custom_name" {
  description = "Name of the Container App Environment, generated if not set."
  type        = string
  default     = ""
}

variable "aca_custom_name" {
  description = "Name of the Container App, generated if not set."
  type        = string
  default     = ""
}
