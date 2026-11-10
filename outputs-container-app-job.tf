output "module_container_app_jobs" {
  description = "Container App Jobs output objects, by key of `container_app_jobs`. Please refer to `./modules/container-app-job/README.md`."
  value       = module.container_app_job

  precondition {
    condition     = length(distinct([for job in module.container_app_job : job.name])) == length(module.container_app_job)
    error_message = "Several Container App Jobs have the same name: set a distinct `custom_name` for them in `container_app_jobs`."
  }
}
