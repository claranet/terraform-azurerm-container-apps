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
module "container_app" {
  source  = "claranet/container-apps/azurerm"
  version = "x.x.x"

  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.name

  client_name = var.client_name
  environment = var.environment
  stack       = var.stack

  containers = [
    {
      name   = "helloworld"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
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

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| container\_app | ./modules/container-app | n/a |
| container\_app\_environment | ./modules/container-app-environment | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| azure\_queue\_scale\_rules | Parameters used to define one or more`azure_queue_scale_rule` object. | <pre>list(object({<br/>    name         = string<br/>    queue_name   = string<br/>    queue_length = string<br/>    authentications = list(object({<br/>      secret_name       = string<br/>      trigger_parameter = string<br/>    }))<br/>  }))</pre> | `[]` | no |
| certificate | Container App Environment Certificate parameters. | <pre>list(object({<br/>    name                    = string<br/>    certificate_blob_base64 = string<br/>    certificate_password    = string<br/>  }))</pre> | `[]` | no |
| client\_name | Client name/account used in naming. | `string` | n/a | yes |
| container\_app\_custom\_name | Name of the Container App, generated if not set. | `string` | `""` | no |
| container\_app\_environment\_custom\_name | Name of the Container App Environment, generated if not set. | `string` | `""` | no |
| containers | Configuration of one or more containers. | <pre>list(object({<br/>    name    = string<br/>    image   = string<br/>    cpu     = number<br/>    memory  = string<br/>    args    = optional(list(string), null)<br/>    command = optional(list(string), null)<br/>    envs = optional(list(object({<br/>      name        = string<br/>      secret_name = optional(string, null)<br/>      value       = optional(string, null)<br/>    })), [])<br/>    liveness_probes = optional(list(object({<br/>      failure_count_threshold = optional(number, 3)<br/>      headers = optional(list(object({<br/>        name  = string<br/>        value = string<br/>      })), [])<br/>      host             = optional(string, null)<br/>      initial_delay    = optional(number, 1)<br/>      interval_seconds = optional(number, 10)<br/>      path             = optional(string, "/")<br/>      port             = number<br/>      timeout          = optional(number, 1)<br/>      transport        = optional(string, null)<br/>    })), [])<br/>    readiness_probes = optional(list(object({<br/>      failure_count_threshold = optional(number, 3)<br/>      headers = optional(list(object({<br/>        name  = string<br/>        value = string<br/>      })), [])<br/>      host                    = optional(string, null)<br/>      initial_delay           = optional(number, 0)<br/>      interval_seconds        = optional(number, 10)<br/>      path                    = optional(string, "/")<br/>      port                    = number<br/>      success_count_threshold = optional(number, 3)<br/>      timeout                 = optional(number, 1)<br/>      transport               = optional(string, null)<br/>    })), [])<br/>    startup_probes = optional(list(object({<br/>      failure_count_threshold = optional(number, 3)<br/>      headers = optional(list(object({<br/>        name  = string<br/>        value = string<br/>      })), [])<br/>      host             = optional(string, null)<br/>      initial_delay    = optional(number, 0)<br/>      interval_seconds = optional(number, 10)<br/>      path             = optional(string, "/")<br/>      port             = number<br/>      timeout          = optional(number, 1)<br/>      transport        = optional(string, null)<br/>    })), [])<br/>    volume_mnt = optional(list(object({<br/>      name = string<br/>      path = string<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| custom\_domain\_certificate\_blob\_base64 | The bundle of Private Key and Certificate for the Custom DNS Suffix as a base64 encoded PFX or PEM. | `string` | `""` | no |
| custom\_domain\_certificate\_password | The password for the Certificate bundle. | `string` | `""` | no |
| custom\_domain\_dns\_suffix | Custom DNS Suffix for the Container App Environment. | `string` | `""` | no |
| custom\_domain\_enabled | Should the Container App Environment be configured with a Custom Domain? Defaults to `false`. | `bool` | `false` | no |
| custom\_scale\_rules | Parameters used to define one or more `custom_scale_rule` object. | <pre>list(object({<br/>    name             = string<br/>    custom_rule_type = string<br/>    metadata         = map(string)<br/>    authentications = optional(list(object({<br/>      secret_name       = string<br/>      trigger_parameter = string<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| dapr\_application\_insights\_connection\_string | Application Insights connection string used by Dapr to export Service to Service communication telemetry. Changing this forces a new resource to be created. | `string` | `null` | no |
| dapr\_components | Dapr Components to be added to the Container App Environment. | <pre>list(object({<br/>    name           = string<br/>    component_type = string<br/>    version        = string<br/>    ignore_errors  = optional(bool, false)<br/>    init_timeout   = optional(string, "5s")<br/>    metadata = list(object({<br/>      name        = string<br/>      value       = optional(string)<br/>      secret_name = optional(string)<br/>    }))<br/>    scopes = list(string)<br/>    secrets = list(object({<br/>      name  = string<br/>      value = string<br/>    }))<br/>  }))</pre> | `[]` | no |
| daprs | Parameters used to define one or more `dapr` object. | <pre>list(object({<br/>    app_id       = string<br/>    app_port     = optional(number)<br/>    app_protocol = optional(string, "http")<br/>  }))</pre> | `[]` | no |
| default\_tags\_enabled | Option to enable or disable default tags. | `bool` | `true` | no |
| environment | Project environment. | `string` | n/a | yes |
| extra\_tags | Additional tags to add on resources. | `map(string)` | `{}` | no |
| http\_scale\_rules | Parameters used to define one or more `http_scale_rule` object. | <pre>list(object({<br/>    name                = string<br/>    concurrent_requests = number<br/>    authentications = optional(list(object({<br/>      secret_name       = string<br/>      trigger_parameter = string<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| identity | Map with identity block information. | <pre>object({<br/>    type         = string<br/>    identity_ids = list(string)<br/>  })</pre> | <pre>{<br/>  "identity_ids": [],<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| infrastructure\_resource\_group\_name | Name of the platform-managed resource group created for the Managed Environment to host infrastructure resources. Changing this forces a new resource to be created. | `string` | `null` | no |
| ingresses | Parameters used to define one or more `ingress` object. | <pre>list(object({<br/>    allow_insecure_connections = optional(bool, false)<br/>    external_enabled           = optional(bool, false)<br/>    ip_security_restrictions = optional(list(object({<br/>      action           = string<br/>      description      = optional(string)<br/>      ip_address_range = string<br/>      name             = string<br/>    })), [])<br/>    target_port  = number<br/>    exposed_port = optional(number)<br/>    traffic_weights = list(object({<br/>      label           = optional(string)<br/>      latest_revision = optional(string)<br/>      revision_suffix = optional(string)<br/>      percentage      = number<br/>    }))<br/>    transport = optional(string, "auto")<br/>  }))</pre> | `[]` | no |
| init\_containers | Configuration of one or more init containers. | <pre>list(object({<br/>    name    = string<br/>    args    = optional(list(string), null)<br/>    command = optional(list(string), null)<br/>    cpu     = optional(number, null)<br/>    image   = string<br/>    memory  = optional(string, null)<br/>    envs = optional(list(object({<br/>      name        = string<br/>      secret_name = optional(string, null)<br/>      value       = optional(string, null)<br/>    })), [])<br/>    ephemeral_storage = optional(string, null)<br/>    volume_mnt = optional(list(object({<br/>      name = string<br/>      path = string<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| location | Azure region to use. | `string` | n/a | yes |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| log\_analytics\_workspace\_id | The ID for the Log Analytics Workspace to link this Container Apps Managed Environment to. Changing this forces a new resource to be created. | `string` | `null` | no |
| max\_inactive\_revisions | The maximum of inactive revisions allowed for this Container App. | `number` | `null` | no |
| mutual\_tls\_enabled | Should mutual transport layer security (mTLS) be enabled? Defaults to `false`. | `bool` | `false` | no |
| name\_prefix | Optional prefix for the generated name. | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name. | `string` | `""` | no |
| registries | Parameters used to define one or more `registry` object. | <pre>list(object({<br/>    server               = string<br/>    identity             = optional(string)<br/>    password_secret_name = optional(string)<br/>    username             = optional(string)<br/>  }))</pre> | `[]` | no |
| resource\_group\_name | Name of the resource group. | `string` | n/a | yes |
| revision\_mode | The revisions operational mode for the Container App. Possible values include `Single` and `Multiple`. In `Single` mode, a single revision is in operation at any given time. In `Multiple` mode, more than one revision can be active at a time and can be configured with load distribution via the `traffic_weight` block in the `ingress` configuration. | `string` | `"Single"` | no |
| revision\_suffix | The suffix for the revision. This value must be unique for the lifetime of the Resource. If omitted the service will use a hash function to create one. | `string` | `""` | no |
| secrets | Parameters used to define one or more `secret` object. | <pre>list(object({<br/>    name                = string<br/>    identity            = optional(string)<br/>    key_vault_secret_id = optional(string)<br/>    value               = optional(string)<br/>  }))</pre> | `[]` | no |
| stack | Project stack name. | `string` | n/a | yes |
| storage | Storage parameters for the Container App Environment. | <pre>list(object({<br/>    name         = string<br/>    account_name = string<br/>    access_key   = string<br/>    share_name   = string<br/>    access_mode  = optional(string, "ReadWrite")<br/>  }))</pre> | `[]` | no |
| tcp\_scale\_rules | Parameters used to define one or more `tcp_scale_rule` object. | <pre>list(object({<br/>    name                = string<br/>    concurrent_requests = number<br/>    authentications = optional(list(object({<br/>      secret_name       = string<br/>      trigger_parameter = string<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| template\_max\_replicas | The maximum number of replicas for this container. | `number` | `null` | no |
| template\_min\_replicas | The minimum number of replicas for this container. | `number` | `null` | no |
| termination\_grace\_period\_seconds | The time in seconds after the container is sent the termination signal before the process if forcibly killed. | `number` | `null` | no |
| volumes | Parameters used to define one or more `volume` object. | <pre>list(object({<br/>    name         = string<br/>    storage_name = optional(string)<br/>    storage_type = optional(string, "EmptyDir")<br/>  }))</pre> | `[]` | no |
| workload\_profile | The profile of the workload to scope the container app execution. | <pre>map(object({<br/>    name                  = optional(string, null)<br/>    workload_profile_type = optional(string, "Consumption")<br/>    maximum_count         = optional(number)<br/>    minimum_count         = optional(number)<br/>  }))</pre> | <pre>{<br/>  "Consumption": {<br/>    "name": "Consumption",<br/>    "workload_profile_type": "Consumption"<br/>  }<br/>}</pre> | no |
| workload\_profile\_name | The name of the Workload Profile in the Container App Environment to place this Container App. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| module\_container\_app | Container App output object. Please refer to `./modules/container-app/README.md`. |
| module\_container\_app\_environment | Container App Environment output object. Please refer to `./modules/container-app-environment/README.md`. |
<!-- END_TF_DOCS -->

## Related documentation

Microsoft Azure documentation: xxxx
