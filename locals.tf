locals {
  # Workload profile used by the Container App and the Container App Jobs that do not set `workload_profile_name`:
  # the first profile of `workload_profile`, by key order, referenced by its `name` (the map key is not sent to Azure).
  default_workload_profile_name = try(values(var.workload_profile)[0].name, null)
}
