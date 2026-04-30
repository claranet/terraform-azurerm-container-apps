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
module "container_app_environment" {
  source  = "claranet/container-apps/azurerm//modules/container-app-environment"
  version = "x.x.x"

  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.name

  client_name = var.client_name
  environment = var.environment
  stack       = var.stack

  logs_destinations_ids = [
    module.logs.storage_account_id,
    module.logs.id
  ]

  extra_tags = {
    foo = "bar"
  }
}
```

## Providers

| Name | Version |
| ---- | ------- |
| azurecaf | >= 1.2.28 |
| azurerm | ~> 4.18 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| diagnostics | claranet/diagnostic-settings/azurerm | ~> 8.2.0 |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_container_app_environment.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment) | resource |
| [azurerm_container_app_environment_certificate.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment_certificate) | resource |
| [azurerm_container_app_environment_custom_domain.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment_custom_domain) | resource |
| [azurerm_container_app_environment_dapr_component.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment_dapr_component) | resource |
| [azurerm_container_app_environment_storage.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_app_environment_storage) | resource |
| [azurecaf_name.container_app_environment](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.infrastructure_rg](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| certificate | Container App Environment Certificate parameters. | <pre>list(object({<br/>    name                    = string<br/>    certificate_blob_base64 = string<br/>    certificate_password    = string<br/>  }))</pre> | `[]` | no |
| client\_name | Client name/account used in naming. | `string` | n/a | yes |
| custom\_domain\_certificate\_blob\_base64 | The bundle of Private Key and Certificate for the Custom DNS Suffix as a base64 encoded PFX or PEM. | `string` | `""` | no |
| custom\_domain\_certificate\_password | The password for the Certificate bundle. | `string` | `""` | no |
| custom\_domain\_dns\_suffix | Custom DNS Suffix for the Container App Environment. | `string` | `""` | no |
| custom\_domain\_enabled | Should the Container App Environment be configured with a Custom Domain? Defaults to `false`. | `bool` | `false` | no |
| custom\_name | Name of the App Service Plan, generated if not set. | `string` | `""` | no |
| dapr\_application\_insights\_connection\_string | Application Insights connection string used by Dapr to export Service to Service communication telemetry. Changing this forces a new resource to be created. | `string` | `null` | no |
| dapr\_components | Dapr Components for the Container App Environment. | <pre>list(object({<br/>    name           = string<br/>    component_type = string<br/>    version        = string<br/>    ignore_errors  = optional(bool, false)<br/>    init_timeout   = optional(string, "5s")<br/>    metadata = list(object({<br/>      name        = string<br/>      value       = optional(string)<br/>      secret_name = optional(string)<br/>    }))<br/>    scopes = list(string)<br/>    secrets = list(object({<br/>      name  = string<br/>      value = string<br/>    }))<br/>  }))</pre> | `[]` | no |
| default\_tags\_enabled | Option to enable or disable default tags. | `bool` | `true` | no |
| diagnostic\_settings\_custom\_name | Custom name of the diagnostics settings, name will be 'default' if not set. | `string` | `"default"` | no |
| environment | Project environment. | `string` | n/a | yes |
| extra\_tags | Extra tags to add. | `map(string)` | `{}` | no |
| infrastructure\_resource\_group\_name | Name of the platform-managed resource group created for the Managed Environment to host infrastructure resources. Changing this forces a new resource to be created. | `string` | `null` | no |
| infrastructure\_subnet | The existing Subnet to use for the Container Apps Control Plane. Changing this forces a new resource to be created. The Subnet must have a `/27` or larger address space. | <pre>object({<br/>    id = string<br/>  })</pre> | `null` | no |
| internal\_load\_balancer\_enabled | Should the Container Environment operate in Internal Load Balancing Mode? Defaults to `false`. Changing this forces a new resource to be created. | `bool` | `false` | no |
| location | Azure location. | `string` | n/a | yes |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| logs\_categories | Log categories to send to destinations. | `list(string)` | `null` | no |
| logs\_destinations\_ids | List of destination resources IDs for logs diagnostic destination.<br/>Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.<br/>If you want to use Azure EventHub as a destination, you must provide a formatted string containing both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the <code>&#124;</code> character. | `list(string)` | n/a | yes |
| logs\_metrics\_categories | Metrics categories to send to destinations. | `list(string)` | `null` | no |
| mutual\_tls\_enabled | Should mutual transport layer security (mTLS) be enabled? Defaults to `false`. | `bool` | `false` | no |
| name\_prefix | Optional prefix for the generated name. | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name. | `string` | `""` | no |
| resource\_group\_name | Resource group name. | `string` | n/a | yes |
| stack | Project stack name. | `string` | n/a | yes |
| storage | Storage parameters for the Container App Environment. | <pre>list(object({<br/>    name           = string<br/>    account_name   = optional(string)<br/>    access_key     = optional(string)<br/>    share_name     = string<br/>    access_mode    = optional(string, "ReadWrite")<br/>    nfs_server_url = optional(string)<br/>  }))</pre> | `[]` | no |
| workload\_profile | The profile of the workload to scope the container app execution. | <pre>map(object({<br/>    name                  = optional(string, null)<br/>    workload_profile_type = optional(string, "Consumption")<br/>    maximum_count         = optional(number)<br/>    minimum_count         = optional(number)<br/>  }))</pre> | <pre>{<br/>  "Consumption": {<br/>    "name": "Consumption",<br/>    "workload_profile_type": "Consumption"<br/>  }<br/>}</pre> | no |
| zone\_redundancy\_enabled | Should the Container App Environment be created with Zone Redundancy enabled? Defaults to `false`. Changing this forces a new resource to be created. | `bool` | `true` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| custom\_domain\_verification\_id | he ID of the Custom Domain Verification for this Container App Environment. |
| default\_domain | The default, publicly resolvable, name of this Container App Environment. |
| docker\_bridge\_cidr | The network addressing in which the Container Apps in this Container App Environment will reside in CIDR notation. |
| id | The ID of the Container App Environment. |
| platform\_reserved\_cidr | The IP range, in CIDR notation, that is reserved for environment infrastructure IP addresses. |
| platform\_reserved\_dns\_ip\_address | The IP address from the IP range defined by `platform_reserved_cidr` that is reserved for the internal DNS server. |
| resource | Container App Environment resource object. |
| static\_ip\_address | The Static IP address of the Environment. |
<!-- END_TF_DOCS -->
