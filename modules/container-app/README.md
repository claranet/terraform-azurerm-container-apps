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

More details are available in the [CONTRIBUTING.md](../../CONTRIBUTING.md#pull-request-process) file.

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

⚠️ Since modules version v8.0.0, we do not maintain/check anymore the compatibility with
[Hashicorp Terraform](https://github.com/hashicorp/terraform/). Instead, we recommend to use [OpenTofu](https://github.com/opentofu/opentofu/).

```hcl
module "container_app" {
  source  = "claranet/container-apps/azurerm//modules/container-app"
  version = "x.x.x"

  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.name

  container_app_environment_id = var.container_app_environment_id

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

| Name | Version |
|------|---------|
| azurecaf | >= 1.2.28 |
| azurerm | ~> 4.49 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_container_app.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app) | resource |
| [azurecaf_name.aca](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| azure\_queue\_scale\_rules | Azure queue scale rule configuration for this Container App. | <pre>list(object({<br/>    name         = string<br/>    queue_name   = string<br/>    queue_length = string<br/>    authentications = list(object({<br/>      secret_name       = string<br/>      trigger_parameter = string<br/>    }))<br/>  }))</pre> | `[]` | no |
| client\_name | Client name/account used in naming. | `string` | n/a | yes |
| container\_app\_environment\_id | The ID of the Container App Environment within which this Container App should exist. Changing this forces a new resource to be created. | `string` | n/a | yes |
| containers | Configuration of one or more containers for this Container App. | <pre>list(object({<br/>    name    = string<br/>    image   = string<br/>    cpu     = number<br/>    memory  = string<br/>    args    = optional(list(string), null)<br/>    command = optional(list(string), null)<br/>    envs = optional(list(object({<br/>      name        = string<br/>      secret_name = optional(string, null)<br/>      value       = optional(string, null)<br/>    })), [])<br/>    liveness_probes = optional(list(object({<br/>      failure_count_threshold = optional(number, 3)<br/>      headers = optional(list(object({<br/>        name  = string<br/>        value = string<br/>      })), [])<br/>      host             = optional(string, null)<br/>      initial_delay    = optional(number, 1)<br/>      interval_seconds = optional(number, 10)<br/>      path             = optional(string, "/")<br/>      port             = number<br/>      timeout          = optional(number, 1)<br/>      transport        = optional(string, null)<br/>    })), [])<br/>    readiness_probes = optional(list(object({<br/>      failure_count_threshold = optional(number, 3)<br/>      headers = optional(list(object({<br/>        name  = string<br/>        value = string<br/>      })), [])<br/>      host                    = optional(string, null)<br/>      initial_delay           = optional(number, 0)<br/>      interval_seconds        = optional(number, 10)<br/>      path                    = optional(string, "/")<br/>      port                    = number<br/>      success_count_threshold = optional(number, 3)<br/>      timeout                 = optional(number, 1)<br/>      transport               = optional(string, null)<br/>    })), [])<br/>    startup_probes = optional(list(object({<br/>      failure_count_threshold = optional(number, 3)<br/>      headers = optional(list(object({<br/>        name  = string<br/>        value = string<br/>      })), [])<br/>      host             = optional(string, null)<br/>      initial_delay    = optional(number, 0)<br/>      interval_seconds = optional(number, 10)<br/>      path             = optional(string, "/")<br/>      port             = number<br/>      timeout          = optional(number, 1)<br/>      transport        = optional(string, null)<br/>    })), [])<br/>    volume_mnt = optional(list(object({<br/>      name     = string<br/>      path     = string<br/>      sub_path = optional(string, null)<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| custom\_name | Custom name for container app. | `string` | `""` | no |
| custom\_scale\_rules | Custom scale rule configuration for this Container App. | <pre>list(object({<br/>    name             = string<br/>    custom_rule_type = string<br/>    metadata         = map(string)<br/>    authentications = optional(list(object({<br/>      secret_name       = string<br/>      trigger_parameter = string<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| daprs | Dapr configuration for this Container App. | <pre>list(object({<br/>    app_id       = string<br/>    app_port     = optional(number)<br/>    app_protocol = optional(string, "http")<br/>  }))</pre> | `[]` | no |
| default\_tags\_enabled | Option to enable or disable default tags. | `bool` | `true` | no |
| environment | Project environment. | `string` | n/a | yes |
| extra\_tags | Extra tags to add. | `map(string)` | `{}` | no |
| http\_scale\_rules | Http scale rule configuration for this Container App. | <pre>list(object({<br/>    name                = string<br/>    concurrent_requests = number<br/>    authentications = optional(list(object({<br/>      secret_name       = string<br/>      trigger_parameter = string<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| identity | Map with identity block information. | <pre>object({<br/>    type         = string<br/>    identity_ids = list(string)<br/>  })</pre> | <pre>{<br/>  "identity_ids": [],<br/>  "type": "SystemAssigned"<br/>}</pre> | no |
| ingresses | Ingress configuration for this Container App. | <pre>list(object({<br/>    allow_insecure_connections = optional(bool, false)<br/>    client_certificate_mode    = optional(string)<br/>    cors = optional(object({<br/>      allowed_origins           = list(string)<br/>      allowed_methods           = optional(list(string))<br/>      allowed_headers           = optional(list(string))<br/>      exposed_headers           = optional(list(string))<br/>      max_age_in_seconds        = optional(number)<br/>      allow_credentials_enabled = optional(bool, false)<br/>    }))<br/>    custom_domains = optional(list(object({<br/>      certificate_binding_type = optional(string)<br/>      certificate_id           = string<br/>      name                     = string<br/>    })), [])<br/>    exposed_port     = optional(number)<br/>    external_enabled = optional(bool, false)<br/>    ip_security_restrictions = optional(list(object({<br/>      action           = string<br/>      description      = optional(string)<br/>      ip_address_range = string<br/>      name             = string<br/>    })), [])<br/>    target_port = number<br/>    traffic_weights = list(object({<br/>      label           = optional(string)<br/>      latest_revision = optional(string)<br/>      revision_suffix = optional(string)<br/>      percentage      = number<br/>    }))<br/>    transport = optional(string, "auto")<br/>  }))</pre> | `[]` | no |
| init\_containers | Init containers configuration for this Container App. | <pre>list(object({<br/>    name    = string<br/>    args    = optional(list(string), null)<br/>    command = optional(list(string), null)<br/>    cpu     = optional(number, null)<br/>    image   = string<br/>    memory  = optional(string, null)<br/>    envs = optional(list(object({<br/>      name        = string<br/>      secret_name = optional(string, null)<br/>      value       = optional(string, null)<br/>    })), [])<br/>    ephemeral_storage = optional(string, null)<br/>    volume_mnt = optional(list(object({<br/>      name     = string<br/>      path     = string<br/>      sub_path = optional(string, null)<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| max\_inactive\_revisions | The maximum of inactive revisions allowed for this Container App. | `number` | `null` | no |
| name\_prefix | Optional prefix for the generated name. | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name. | `string` | `""` | no |
| registries | Registries configuration for this Container App. | <pre>list(object({<br/>    server               = string<br/>    identity             = optional(string)<br/>    password_secret_name = optional(string)<br/>    username             = optional(string)<br/>  }))</pre> | `[]` | no |
| resource\_group\_name | Resource group name. | `string` | n/a | yes |
| revision\_mode | The revisions operational mode for the Container App. Possible values include `Single` and `Multiple`. In `Single` mode, a single revision is in operation at any given time. In `Multiple` mode, more than one revision can be active at a time and can be configured with load distribution via the `traffic_weight` block in the `ingress` configuration. | `string` | `"Single"` | no |
| revision\_suffix | The suffix for the revision. This value must be unique for the lifetime of the Resource. If omitted the service will use a hash function to create one. | `string` | `""` | no |
| secrets | Secrets configuration for this Container App. | <pre>list(object({<br/>    name                = string<br/>    identity            = optional(string)<br/>    key_vault_secret_id = optional(string)<br/>    value               = optional(string)<br/>  }))</pre> | `[]` | no |
| stack | Project stack name. | `string` | n/a | yes |
| tcp\_scale\_rules | Tcp scale rule configuration for this Container App. | <pre>list(object({<br/>    name                = string<br/>    concurrent_requests = number<br/>    authentications = optional(list(object({<br/>      secret_name       = string<br/>      trigger_parameter = string<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| template\_max\_replicas | The maximum number of replicas for this Container App. | `number` | `null` | no |
| template\_min\_replicas | The minimum number of replicas for this Container App. | `number` | `null` | no |
| termination\_grace\_period\_seconds | The time in seconds after the container is sent the termination signal before the process if forcibly killed. | `number` | `null` | no |
| volumes | Volume configuration for this Container App. | <pre>list(object({<br/>    name         = string<br/>    storage_name = optional(string)<br/>    storage_type = optional(string, "EmptyDir")<br/>  }))</pre> | `[]` | no |
| workload\_profile\_name | The name of the Workload Profile in the Container App Environment to place this Container App. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| custom\_domain\_verification\_id | ID of the Custom Domain Verification for this Container App. |
| id | Azure Container Apps ID. |
| identity\_principal\_id | Azure Container Apps system identity principal ID. |
| latest\_revision\_fqdn | FQDN of the Latest Revision of the Container App. |
| latest\_revision\_name | Name of the latest Container Revision. |
| name | Azure Container Apps name. |
| outbound\_ip\_addresses | List of the Public IP Addresses which the Container App uses for outbound network access. |
| resource | Azure Container Apps resource object. |
<!-- END_TF_DOCS -->
