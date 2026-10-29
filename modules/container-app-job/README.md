<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | OpenTofu version | AzureRM version |
| -------------- | ----------------- | ---------------- | --------------- |
| >= 9.x.x       | **Unverified**    | 1.12.x           | >= 5.0          |
| >= 8.x.x       | **Unverified**    | 1.8.x            | >= 4.0          |
| >= 7.x.x       | 1.3.x             |                  | >= 3.0          |
| >= 6.x.x       | 1.x               |                  | >= 3.0          |
| >= 5.x.x       | 0.15.x            |                  | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   |                  | >= 2.0          |
| >= 3.x.x       | 0.12.x            |                  | >= 2.0          |
| >= 2.x.x       | 0.12.x            |                  | < 2.0           |
| <  2.x.x       | 0.11.x            |                  | < 2.0           |

## Contributing

If you want to contribute to this repository, feel free to use our [pre-commit](https://pre-commit.com/) git hook configuration
which will help you automatically update and format some files for you by enforcing our Terraform code module best-practices.

More details are available in the [CONTRIBUTING.md](../../CONTRIBUTING.md#pull-request-process) file.

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

⚠️ Since modules version v8.0.0, we do not maintain/check anymore the compatibility with
[Hashicorp Terraform](https://github.com/hashicorp/terraform/). Instead, we recommend to use [OpenTofu](https://github.com/opentofu/opentofu/).

```hcl
module "container_app_job" {
  source  = "claranet/container-apps/azurerm//modules/container-app-job"
  version = "x.x.x"

  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.name

  container_app_environment_id = var.container_app_environment_id

  client_name = var.client_name
  environment = var.environment
  stack       = var.stack

  schedule_trigger_config = {
    cron_expression = "0 22 * * *"
  }
  replica_timeout_in_seconds = 600
  replica_retry_limit        = 0

  containers = [
    {
      name   = "job"
      image  = "mcr.microsoft.com/k8se/quickstart-jobs:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    },
  ]

  extra_tags = {
    foo = "bar"
  }
}
```

## Providers

| Name | Version |
| ---- | ------- |
| azurecaf | ~> 1.3.0 |
| azurerm | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_container_app_job.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_job) | resource |
| [azurecaf_name.acj](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| client\_name | Client name/account used in naming. | `string` | n/a | yes |
| container\_app\_environment\_id | ID of the Container App Environment in which to create the Container App Job. | `string` | n/a | yes |
| containers | Configuration of one or more containers. | <pre>list(object({<br/>    name    = string<br/>    image   = string<br/>    cpu     = number<br/>    memory  = string<br/>    args    = optional(list(string), null)<br/>    command = optional(list(string), null)<br/>    envs = optional(list(object({<br/>      name        = string<br/>      secret_name = optional(string, null)<br/>      value       = optional(string, null)<br/>    })), [])<br/>    liveness_probes = optional(list(object({<br/>      failure_count_threshold = optional(number, 3)<br/>      headers = optional(list(object({<br/>        name  = string<br/>        value = string<br/>      })), [])<br/>      host             = optional(string, null)<br/>      initial_delay    = optional(number, 1)<br/>      interval_seconds = optional(number, 10)<br/>      path             = optional(string, "/")<br/>      port             = number<br/>      timeout          = optional(number, 1)<br/>      transport        = optional(string, "HTTP")<br/>    })), [])<br/>    readiness_probes = optional(list(object({<br/>      failure_count_threshold = optional(number, 3)<br/>      headers = optional(list(object({<br/>        name  = string<br/>        value = string<br/>      })), [])<br/>      host                    = optional(string, null)<br/>      initial_delay           = optional(number, 0)<br/>      interval_seconds        = optional(number, 10)<br/>      path                    = optional(string, "/")<br/>      port                    = number<br/>      success_count_threshold = optional(number, 3)<br/>      timeout                 = optional(number, 1)<br/>      transport               = optional(string, "HTTP")<br/>    })), [])<br/>    startup_probes = optional(list(object({<br/>      failure_count_threshold = optional(number, 3)<br/>      headers = optional(list(object({<br/>        name  = string<br/>        value = string<br/>      })), [])<br/>      host             = optional(string, null)<br/>      initial_delay    = optional(number, 0)<br/>      interval_seconds = optional(number, 10)<br/>      path             = optional(string, "/")<br/>      port             = number<br/>      timeout          = optional(number, 1)<br/>      transport        = optional(string, "HTTP")<br/>    })), [])<br/>    volume_mnt = optional(list(object({<br/>      name     = string<br/>      path     = string<br/>      sub_path = optional(string, null)<br/>    })), [])<br/>  }))</pre> | n/a | yes |
| custom\_name | Custom name for the Container App Job. | `string` | `""` | no |
| default\_tags\_enabled | Option to enable or disable default tags. | `bool` | `true` | no |
| environment | Project environment. | `string` | n/a | yes |
| event\_trigger\_config | Event trigger of the Container App Job, with its KEDA scale rules. Exactly one of `manual_trigger_config`, `schedule_trigger_config` and `event_trigger_config` must be set. | <pre>object({<br/>    parallelism              = optional(number, 1)<br/>    replica_completion_count = optional(number, 1)<br/>    scale = optional(object({<br/>      max_executions              = optional(number, 100)<br/>      min_executions              = optional(number, 0)<br/>      polling_interval_in_seconds = optional(number, 30)<br/>      rules = optional(list(object({<br/>        name             = string<br/>        custom_rule_type = string<br/>        metadata         = map(string)<br/>        identity_id      = optional(string)<br/>        authentications = optional(list(object({<br/>          secret_name       = string<br/>          trigger_parameter = string<br/>        })), [])<br/>      })), [])<br/>    }))<br/>  })</pre> | `null` | no |
| extra\_tags | Extra tags to add. | `map(string)` | `{}` | no |
| identity | Map with identity block information. | <pre>object({<br/>    type         = string<br/>    identity_ids = list(string)<br/>  })</pre> | <pre>{<br/>  "identity_ids": [],<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| init\_containers | Configuration of one or more init containers. | <pre>list(object({<br/>    name    = string<br/>    args    = optional(list(string), null)<br/>    command = optional(list(string), null)<br/>    cpu     = optional(number, null)<br/>    image   = string<br/>    memory  = optional(string, null)<br/>    envs = optional(list(object({<br/>      name        = string<br/>      secret_name = optional(string, null)<br/>      value       = optional(string, null)<br/>    })), [])<br/>    volume_mnt = optional(list(object({<br/>      name     = string<br/>      path     = string<br/>      sub_path = optional(string, null)<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| location | Azure region to use. | `string` | n/a | yes |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| manual\_trigger\_config | Manual trigger of the Container App Job, started on demand. Exactly one of `manual_trigger_config`, `schedule_trigger_config` and `event_trigger_config` must be set. | <pre>object({<br/>    parallelism              = optional(number, 1)<br/>    replica_completion_count = optional(number, 1)<br/>  })</pre> | `null` | no |
| name\_prefix | Optional prefix for the generated name. | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name. | `string` | `""` | no |
| registries | Parameters used to define one or more `registry` object. | <pre>list(object({<br/>    server               = string<br/>    identity             = optional(string)<br/>    password_secret_name = optional(string)<br/>    username             = optional(string)<br/>  }))</pre> | `[]` | no |
| replica\_retry\_limit | Maximum number of times a replica is allowed to retry. | `number` | `null` | no |
| replica\_timeout\_in\_seconds | Maximum number of seconds a replica is allowed to run. | `number` | `1800` | no |
| resource\_group\_name | Resource group name. | `string` | n/a | yes |
| schedule\_trigger\_config | Schedule trigger of the Container App Job. `cron_expression` is evaluated in UTC. Exactly one of `manual_trigger_config`, `schedule_trigger_config` and `event_trigger_config` must be set. | <pre>object({<br/>    cron_expression          = string<br/>    parallelism              = optional(number, 1)<br/>    replica_completion_count = optional(number, 1)<br/>  })</pre> | `null` | no |
| secrets | Parameters used to define one or more `secret` object. | <pre>list(object({<br/>    name                = string<br/>    identity            = optional(string)<br/>    key_vault_secret_id = optional(string)<br/>    value               = optional(string)<br/>  }))</pre> | `[]` | no |
| stack | Project stack name. | `string` | n/a | yes |
| volumes | Parameters used to define one or more `volume` object. With `storage_type = "Secret"`, the secrets of the Container App Job are mounted as files. | <pre>list(object({<br/>    name          = string<br/>    storage_name  = optional(string)<br/>    storage_type  = optional(string, "EmptyDir")<br/>    mount_options = optional(string)<br/>  }))</pre> | `[]` | no |
| workload\_profile\_name | Name of the Workload Profile of the Container App Environment used by the Container App Job. | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| event\_stream\_endpoint | Endpoint of the event stream of the Container App Job. |
| id | Azure Container App Job ID. |
| identity\_principal\_id | Azure Container App Job system identity principal ID. |
| name | Azure Container App Job name. |
| outbound\_ip\_addresses | List of the Public IP Addresses which the Container App Job uses for outbound network access. |
| resource | Azure Container App Job resource object. |
<!-- END_TF_DOCS -->
