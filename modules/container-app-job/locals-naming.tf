locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  name = coalesce(var.custom_name, data.azurecaf_name.acj.result)

  # Name azurecaf generates when no part has to be trimmed, with the same input cleaning (characters
  # other than lowercase alphanumerics and hyphens are removed). It differs from the result when the name exceeds 32 characters.
  untrimmed_name = join("-", compact([
    for part in [local.name_prefix, "caj-${var.stack}", var.client_name, var.location_short, var.environment, local.name_suffix] : replace(part, "/[^a-z0-9-]/", "")
  ]))
}
