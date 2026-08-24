## 9.0.0 (2026-08-24)

### ⚠ BREAKING CHANGES

* **SREAA-368:** AzureRM provider bumped to ~> 5.0. The azurerm_container_app_environment resource logs_destination value changed from "azure-
  monitor" to "log-analytics". Minimum OpenTofu version raised to 1.12.

### Features

* **SREAA-368:** upgrade module to v9 (OpenTofu >= 1.12, AzureRM ~> 5.0) 03d092f

### Documentation

* **SREAA-368:** 📚️ regenerate the submodule READMEs 9405683

### Continuous Integration

* **SREAA-368:** 👷 point the pipeline include back at the ci master branch 6446868

### Miscellaneous Chores

* **deps:** update dependency opentofu to v1.12.5 9256339
* **deps:** update dependency tflint to v0.64.0 dd979e4
* **SREAA-368:** 🔗 bump azurecaf to ~> 1.3.0 and resync the ci template files 68bb3ce
* **v9:** 🐛 synchronize common files and docs d9f7cab

## 8.5.2 (2026-07-20)

### Bug Fixes

* **tflint:** 🐛 bump Azure rules version, fix signature bug a0e1c08

### Miscellaneous Chores

* **deps:** update dependency opentofu to v1.12.1 5a1de82
* **deps:** update dependency opentofu to v1.12.2 5bb4a0d
* **deps:** update dependency opentofu to v1.12.3 c43be7b
* **deps:** update dependency opentofu to v1.12.4 996a635
* **deps:** update dependency tflint to v0.63.1 6972951
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.4.1 2891724
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.4.2 a10b4f8

## 8.5.1 (2026-06-03)

### Bug Fixes

* 🐛 default output `resource` now require sensitive with OpenTofu 1.12+ 986f830

### Miscellaneous Chores

* **deps:** update dependency opentofu to v1.11.7 4711232
* **deps:** update dependency opentofu to v1.12.0 483092b
* **deps:** update dependency terraform-docs to v0.23.0 07fd38f
* **deps:** update dependency terraform-docs to v0.24.0 45476f6
* **deps:** update dependency tflint to v0.62.1 0f9b61d
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.4.0 f7e82c5
* **tfdocs:** bump tfdocs to v0.22 🔧 05d8226

## 8.5.0 (2026-04-30)

### Features

* **AZ-1655:** add probes path conditions if transport is TCP 42bdea5

### Bug Fixes

* **AZ-1655:** fix typo 47dbe4d

### Miscellaneous Chores

* **deps:** 🔗 update mise conf for OpenTofu 21c1648
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.3.0 f0b3563
* **deps:** update tools 0049c9e
* **pre-commit:** 🔧 move to prek 965c926

## 8.4.2 (2026-03-27)

### Bug Fixes

* **trivy:** 🐛 drop unsafe trivy pre-commit 🔒️ cd47b96

### Code Refactoring

* update module structure and Github actions 👷 589b2e2

### Miscellaneous Chores

* **AI:** 🤖 add AI Agents instructions for Contributing 59c3213
* **deps:** 🔗 bump tflint rules version 3196666
* **deps:** 🔗 bump tflint rules version 57ab0f6
* **deps:** update dependency trivy to v0.69.2 b575e61
* **deps:** update dependency trivy to v0.69.3 50632b7
* **deps:** update dependency trivy to v0.69.4 fe9081c
* **deps:** update pre-commit hook crate-ci/committed to v1.1.11 75b0cc9

### Revert

* chore(deps): update dependency trivy to v0.69.4 🔒️ ae0973a

## 8.4.1 (2026-02-13)

### Code Refactoring

* **gitlab MR template:** ♻️ update default reviewers group with Azure Factory 🔧 9c49104

### Miscellaneous Chores

* **deps:** update dependency opentofu to v1.11.2 c890b82
* **deps:** update dependency opentofu to v1.11.3 e14b7d2
* **deps:** update dependency opentofu to v1.11.4 d1ca167
* **deps:** update dependency opentofu to v1.11.5 226ff46
* **deps:** update dependency pre-commit to v4.4.0 4ed1484
* **deps:** update dependency pre-commit to v4.5.0 6b5c0ee
* **deps:** update dependency pre-commit to v4.5.1 58521d9
* **deps:** update dependency tflint to v0.60.0 bf5def9
* **deps:** update dependency tflint to v0.61.0 6ba9385
* **deps:** update dependency trivy to v0.68.1 b900fe2
* **deps:** update dependency trivy to v0.68.2 1c94131
* **deps:** update dependency trivy to v0.69.0 8c9aeff
* **deps:** update dependency trivy to v0.69.1 92cbd7e
* **deps:** update pre-commit hook crate-ci/committed to v1.1.10 23a33e9
* **deps:** update pre-commit hook crate-ci/committed to v1.1.8 84953b1
* **deps:** update pre-commit hook crate-ci/committed to v1.1.9 2e3d1b6
* **deps:** update tools e09a0b4

## 8.4.0 (2025-11-07)

### Features

* **AZ-1619:** add tagging to environment certificates a6d1e67

### Miscellaneous Chores

* apply suggestions 41eca6f
* **deps:** update dependency opentofu to v1.10.7 17593fb

## 8.3.0 (2025-10-24)

### Features

* **ingresses:** 🌟 add support for `client_certificate_mode`, `cors`, and `custom_domain` 39a6a70
* **nfs/storage:** update storage parameters for Container App Environment ff58897

### Miscellaneous Chores

* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.2.2 d15c3ae

## 8.2.1 (2025-10-13)

### Bug Fixes

* **GH-1:** 🐛 add `sub_path` in `volume_mounts` 65e4702

### Miscellaneous Chores

* **deps:** update dependency trivy to v0.67.1 248fea5
* **deps:** update dependency trivy to v0.67.2 e9198b1

## 8.2.0 (2025-10-08)

### Features

* vnet integration e4cd822

## 8.1.3 (2025-10-02)

### Bug Fixes

* add name_prefix and name_suffix variables to container app environment 2673ff4

## 8.1.2 (2025-09-30)

### Code Refactoring

* **deps:** 🔗 update claranet/azurecaf to ~> 1.3.0 🔧 46b1a7c
* **deps:** 🔗 update claranet/azurecaf to ~> 1.3.0 🔧 7cb74d6
* **deps:** 🔗 update claranet/azurecaf to ~> 1.3.0 🔧 e22fe93

### Miscellaneous Chores

* **deps:** update dependency trivy to v0.67.0 73e3598

## 8.1.1 (2025-09-26)

### Revert

* "feat: use azapi provider for managing container app secrets to avoid cycles" 5fcb7d8

## 8.1.0 (2025-09-26)

### Features

* implement diagnostic settings and logging configuration for container apps 9d2bd11
* use azapi provider for managing container app secrets to avoid cycles a89b880

### Bug Fixes

* update container app example 39cc68a
* update workload profile handling b6dbceb

### Miscellaneous Chores

* **deps:** 🔗 bump AzureRM provider version to v4.31+ 38be212
* **deps:** update dependency opentofu to v1.10.3 f2ef699
* **deps:** update dependency opentofu to v1.10.6 9c7f03c
* **deps:** update dependency tflint to v0.58.1 37a384d
* **deps:** update dependency tflint to v0.59.1 82801a4
* **deps:** update dependency trivy to v0.66.0 3f57d8e
* **deps:** update pre-commit hook pre-commit/pre-commit-hooks to v6 836287d
* **deps:** update tools a959c3e
* **deps:** update tools cb21755

## 8.0.0 (2025-07-11)

### ⚠ BREAKING CHANGES

* **AZ-1084:** init Azure Container Apps module

### Features

* **AZ-1084:** ✨ add container app and environment modules examples a7666e2
* **AZ-1084:** init Azure Container Apps module e10767b
* **AZ-1084:** move ACA ressource into a submodule 249facc
* **AZ-1085:** update variables descriptions 0b0ac1a

### Bug Fixes

* **AZ-1084:** more reworks on the module 05b9a8c
* **AZ-1084:** rework module for v.8 61c0a30

### Code Refactoring

* ♻️ update submodules 3b42c53
* **AZ-1084:** add new variables e7c3664

### Miscellaneous Chores

* **⚙️:** ✏️ update template identifier for MR review 53920c3
* 🗑️ remove old commitlint configuration files fb48c06
* **deps:** update dependency opentofu to v1.10.1 cfb7227
* **deps:** update dependency opentofu to v1.7.1 1c5c83a
* **deps:** update dependency opentofu to v1.7.2 5f4200a
* **deps:** update dependency opentofu to v1.7.3 d395ad1
* **deps:** update dependency opentofu to v1.8.2 5d830d9
* **deps:** update dependency opentofu to v1.8.3 5383e44
* **deps:** update dependency opentofu to v1.8.4 df25bf1
* **deps:** update dependency opentofu to v1.8.6 01a3eca
* **deps:** update dependency opentofu to v1.8.7 cfe8532
* **deps:** update dependency opentofu to v1.9.0 f4b11a4
* **deps:** update dependency opentofu to v1.9.1 9d14e6b
* **deps:** update dependency pre-commit to v3.7.1 d548657
* **deps:** update dependency pre-commit to v3.8.0 7fa2f6f
* **deps:** update dependency pre-commit to v4 973e060
* **deps:** update dependency pre-commit to v4.0.1 ebf40bb
* **deps:** update dependency pre-commit to v4.1.0 9d6abe3
* **deps:** update dependency pre-commit to v4.2.0 ce19b8e
* **deps:** update dependency terraform-docs to v0.18.0 3ae9192
* **deps:** update dependency terraform-docs to v0.20.0 84be7c8
* **deps:** update dependency tflint to v0.51.1 9c7e174
* **deps:** update dependency tflint to v0.51.2 0bbe4f1
* **deps:** update dependency tflint to v0.52.0 5df588d
* **deps:** update dependency tflint to v0.54.0 4141481
* **deps:** update dependency tflint to v0.55.0 912906b
* **deps:** update dependency tflint to v0.55.1 a6c8039
* **deps:** update dependency tflint to v0.58.0 1bf545d
* **deps:** update dependency trivy to v0.51.1 f9e1111
* **deps:** update dependency trivy to v0.51.2 c76fc99
* **deps:** update dependency trivy to v0.51.4 4568f30
* **deps:** update dependency trivy to v0.52.0 0acd80e
* **deps:** update dependency trivy to v0.52.1 71c4474
* **deps:** update dependency trivy to v0.52.2 9b78c5e
* **deps:** update dependency trivy to v0.53.0 b03289e
* **deps:** update dependency trivy to v0.55.0 4baf06b
* **deps:** update dependency trivy to v0.55.1 7d71098
* **deps:** update dependency trivy to v0.55.2 a0a1c5d
* **deps:** update dependency trivy to v0.56.0 e7572d5
* **deps:** update dependency trivy to v0.56.1 57819e4
* **deps:** update dependency trivy to v0.56.2 143d44f
* **deps:** update dependency trivy to v0.57.1 3b0ea51
* **deps:** update dependency trivy to v0.58.0 eaa0ede
* **deps:** update dependency trivy to v0.58.2 ac6dadf
* **deps:** update dependency trivy to v0.59.0 4454f16
* **deps:** update dependency trivy to v0.59.1 db5901b
* **deps:** update dependency trivy to v0.60.0 c41ebbc
* **deps:** update dependency trivy to v0.61.1 337e003
* **deps:** update dependency trivy to v0.63.0 082ec2b
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.17.0 ec0d316
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.18.0 f4a91b0
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.19.0 ce43fae
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.20.0 15dbf23
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.21.0 23e25d2
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.22.0 992d1f4
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.0 4574a87
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.93.0 741219e
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.0 1d7b792
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.1 afa35b7
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.2 a8b78d8
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.3 3533252
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.95.0 2576d01
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.96.0 13890ab
* **deps:** update pre-commit hook pre-commit/pre-commit-hooks to v5 5c51463
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.1.0 7dd2059
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.2.0 2555041
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.2.1 53658e6
* **deps:** update tools 975d4ec
* **deps:** update tools 60ad317
* **deps:** update tools 295ce95
* **deps:** update tools 3788d03
* **deps:** update tools 0717b48
* **deps:** update tools d4b937a
* **deps:** update tools f56e38f
* **deps:** update tools d756e7f
* update Github templates d999a61
* update tflint config for v0.55.0 5461b23
