# Azure Container Apps
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-blue.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![OpenTofu Registry](https://img.shields.io/badge/opentofu-registry-yellow.svg)](https://search.opentofu.org/module/claranet/aca/azurerm/latest)

Azure module to deploy a [Azure Container Apps](https://docs.microsoft.com/en-us/azure/xxxxxxx).

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | OpenTofu version | AzureRM version |
| -------------- | ----------------- | ---------------- | --------------- |
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

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

⚠️ Since modules version v8.0.0, we do not maintain/check anymore the compatibility with
[Hashicorp Terraform](https://github.com/hashicorp/terraform/). Instead, we recommend to use [OpenTofu](https://github.com/opentofu/opentofu/).

```hcl
module "aca" {
  source  = "claranet/aca/azurerm"
  version = "x.x.x"

  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.name

  client_name = var.client_name
  environment = var.environment
  stack       = var.stack

  logs_destinations_ids = [
    module.run.logs_storage_account_id,
    module.run.log_analytics_workspace_id
  ]

  extra_tags = {
    foo = "bar"
  }
}
```

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| aca | ./module/container-app | n/a |
| aca\_env | ./module/container-app-environment | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aca\_custom\_name | Name of the Container App, generated if not set. | `string` | `""` | no |
| aca\_env\_custom\_name | Name of the Container App Environment, generated if not set. | `string` | `""` | no |
| client\_name | Client name/account used in naming. | `string` | n/a | yes |
| containers | Container configuration object with following attributes:<pre>- name:                           xxxxxxxxxxxxxx</pre> | <pre>list(object({<br/>    name    = string<br/>    image   = string<br/>    cpu     = number<br/>    memory  = string<br/>    args    = optional(list(string), null)<br/>    command = optional(list(string), null)<br/>    envs = optional(list(object({<br/>      name        = optional(string, null)<br/>      secret_name = optional(string, null)<br/>      value       = optional(string, null)<br/>    })))<br/>    liveness_probes = optional(list(object({<br/>      failure_count_threshold = optional(number, 3)<br/>      headers = optional(list(object({<br/>        name  = optional(string)<br/>        value = optional(string)<br/>      })))<br/>      host                    = optional(string)<br/>      initial_delay           = optional(number)<br/>      interval_seconds        = optional(number, 10)<br/>      path                    = optional(string, "/")<br/>      port                    = optional(number)<br/>      success_count_threshold = optional(number, 3)<br/>      timeout                 = optional(number, 1)<br/>      transport               = optional(string)<br/>    })))<br/>    readiness_probes = optional(list(object({<br/>      failure_count_threshold = optional(number, 3)<br/>      headers = optional(list(object({<br/>        name  = optional(string)<br/>        value = optional(string)<br/>      })))<br/>      host                             = optional(string)<br/>      interval_seconds                 = optional(number, 10)<br/>      path                             = optional(string, "/")<br/>      port                             = optional(number)<br/>      termination_grace_period_seconds = optional(number)<br/>      timeout                          = optional(number, 1)<br/>      transport                        = optional(string)<br/>    })))<br/>    startup_probes = optional(list(object({<br/>      failure_count_threshold = optional(number, 3)<br/>      headers = optional(list(object({<br/>        name  = optional(string)<br/>        value = optional(string)<br/>      })))<br/>      host                             = optional(string)<br/>      interval_seconds                 = optional(number, 10)<br/>      path                             = optional(string, "/")<br/>      port                             = optional(number)<br/>      termination_grace_period_seconds = optional(number)<br/>      timeout                          = optional(number, 1)<br/>      transport                        = optional(string)<br/>    })))<br/>    volume_mnt = optional(list(object({<br/>      name = optional(string, null)<br/>      path = optional(string, null)<br/>    })))<br/>  }))</pre> | `[]` | no |
| dapr\_application\_insights\_connection\_string | Application Insights connection string used by Dapr to export Service to Service communication telemetry. | `string` | `null` | no |
| daprs | A `dapr` object with following attributes:<pre>- name:                           xxxxxxxxxxxxxx</pre> | <pre>list(object({<br/>    app_id       = string<br/>    app_port     = optional(number)<br/>    app_protocol = optional(string, "http")<br/>  }))</pre> | `[]` | no |
| default\_tags\_enabled | Option to enable or disable default tags. | `bool` | `true` | no |
| environment | Project environment. | `string` | n/a | yes |
| extra\_tags | Additional tags to add on resources. | `map(string)` | `{}` | no |
| identity | Map with identity block information. | <pre>object({<br/>    type         = string<br/>    identity_ids = list(string)<br/>  })</pre> | <pre>{<br/>  "identity_ids": [],<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| ingresses | An `ingress` object with following attributes:<pre>- name:                           xxxxxxxxxxxxxx</pre> | <pre>list(object({<br/><br/>  }))</pre> | `[]` | no |
| location | Azure region to use. | `string` | n/a | yes |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| log\_analytics\_workspace\_id | The ID for the Log Analytics Workspace to link this Container Apps Managed Environment to. Changing this forces a new resource to be created. | `string` | `null` | no |
| name\_prefix | Optional prefix for the generated name. | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name. | `string` | `""` | no |
| registries | A `registry` object with following attributes:<pre>- name:                           xxxxxxxxxxxxxx</pre> | <pre>list(object({<br/>    allow_insecure_connections = bool<br/>    custom_domain = optional(list(object({<br/>      certificate_binding_type = optional(string, "Disabled")<br/>      certificate_id           = string<br/>      name                     = string<br/>    })))<br/>    fqdn             = optional(string)<br/>    external_enabled = optional(bool)<br/>    target_port      = number<br/>    traffic_weight = list(object({<br/>      label           = optional(string)<br/>      latest_revision = optional(string)<br/>      revision_suffix = optional(string)<br/>      percentage      = number<br/>    }))<br/>    transport = optional(string, "auto")<br/>  }))</pre> | `[]` | no |
| resource\_group\_name | Name of the resource group. | `string` | n/a | yes |
| secrets | Secret configuration object with following attributes:<pre>Secrets cannot be removed from the service once added, attempting to do so will result in an error.<br/>Their values may be zeroed, i.e. set to `""`, but the named secret must persist.<br/>- name: The secret name.<br/>- value: The value for this secret.</pre> | <pre>list(object({<br/>    name  = string<br/>    value = string<br/>  }))</pre> | `[]` | no |
| stack | Project stack name. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| resource | Container App Environment resource object. |
<!-- END_TF_DOCS -->

## Related documentation

Microsoft Azure documentation: xxxx
