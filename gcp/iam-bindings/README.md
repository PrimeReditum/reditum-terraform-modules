# Google IAM Custom Terraform Modules

This is a collection of resources that make it easier to non-destructively manage multiple IAM roles for resources on GCP

## Compatibility
This module is mant for use with Terraform 1.0+

## IAM Bindings
You can choose the following resource types to apply in the IAM bindings:

- Projects (`projects` variable)
- Organizations(`organizations` variable)
- Folders (`folders` variable)
- Service Accounts (`service_accounts` variable)
- Subnetworks (`subnets` variable)
- Storage buckets (`storage_buckets` variable)
- Pubsub topics (`pubsub_topics` variable)
- Pubsub subscriptions (`pubsub_subscriptions` variable)
- Kms Key Rings (`kms_key_rings` variable)
- Kms Crypto Keys (`kms_crypto_keys` variable)
- Secret Manager Secrets (`secrets` variable)
- DNS Zones (`managed_zones` variable)

Set the specified variable on the module call to choose the resources to affect.

### Permissions

In order to execute a submodule you must have a Service Account with an appropriate role to manage IAM for the applicable resource. The appropriate role differs depending on which resource you are targeting, as follows:

- Organization:
  - Organization Administrator: Access to administer all resources belonging to the organization
    and does not include privileges for billing or organization role administration.
  - Custom: Add resourcemanager.organizations.getIamPolicy and
    resourcemanager.organizations.setIamPolicy permissions.
- Project:
  - Owner: Full access and all permissions for all resources of the project.
  - Projects IAM Admin: allows users to administer IAM policies on projects.
  - Custom: Add resourcemanager.projects.getIamPolicy and resourcemanager.projects.setIamPolicy permissions.
- Folder:
  - The Folder Admin: All available folder permissions.
  - Folder IAM Admin: Allows users to administer IAM policies on folders.
  - Custom: Add resourcemanager.folders.getIamPolicy and
    resourcemanager.folders.setIamPolicy permissions (must be added in the organization).
- Storage bucket:
  - Storage Admin: Full control of GCS resources.
  - Storage Legacy Bucket Owner: Read and write access to existing
    buckets with object listing/creation/deletion.
  - Custom: Add storage.buckets.getIamPolicy	and
  storage.buckets.setIamPolicy permissions.
- Kms Key Ring:
  - Owner: Full access to all resources.
  - Cloud KMS Admin: Enables management of crypto resources.
  - Custom: Add cloudkms.keyRings.getIamPolicy and cloudkms.keyRings.getIamPolicy permissions.
- Kms Crypto Key:
  - Owner: Full access to all resources.
  - Cloud KMS Admin: Enables management of cryptoresources.
  - Custom: Add cloudkms.cryptoKeys.getIamPolicy	and cloudkms.cryptoKeys.setIamPolicy permissions.
- Secret Manager:
    - Secret Manager Admin: Full access to administer Secret Manager.
    - Custom: Add secretmanager.secrets.getIamPolicy and secretmanager.secrets.setIamPolicy permissions.

## Usage
In order to use this module, create a `bindings.json` file on the same place where the module is called.

### Organization Bindings
```json
{
  "locals": {
    "organization_iam": [
      {
        "organization_id": "<organization-id>",
        "role": "<role>",
        "condition": {
          "title": "<title>",
          "description": "<description>",
          "expression": "<expression>"
        }
      }
    ],
    "project_iam": [],
    "external_project_iam": [],
    "folder_iam": [],
    "resource_iam": []
  }
}
```

### Project Bindings
```json
{
  "locals": {
    "organization_iam": [],
    "project_iam": [
      {
        "project_id": "<project-id>",
        "role": "<role>",
        "condition": {
          "title": "<title>",
          "description": "<description>",
          "expression": "<expression>"
        }
      }
    ],
    "external_project_iam": [],
    "folder_iam": [],
    "resource_iam": []
  }
}
```

### External Project Bindings
```json
{
  "locals": {
    "organization_iam": [],
    "project_iam": [],
    "external_project_iam": [
      {
        "project_id": "<project-id>",
        "role": "<role>",
        "condition": {
          "title": "<title>",
          "description": "<description>",
          "expression": "<expression>"
        }
      }
    ],
    "folder_iam": [],
    "resource_iam": []
  }
}
```

### Folder Bindings
```json
{
  "locals": {
    "organization_iam": [],
    "project_iam": [],
    "external_project_iam": [],
    "folder_iam": [
      {
        "folder_id": "<folder-id>",
        "role": "<role>",
        "condition": {
          "title": "<title>",
          "description": "<description>",
          "expression": "<expression>"
        }
      }
    ],
    "resource_iam": []
  }
}
```

### Cloud Run Service Bindings
```json
{
  "locals": {
    "organization_iam": [],
    "project_iam": [],
    "external_project_iam": [],
    "folder_iam": [],
    "resource_iam": [
      {
        "resource_type": "cloud_run_service",
        "location": "<cloud-run-service-location>",
        "name": "<cloud-run-service-name>",
        "project_id": "<project-id>",
        "role": "<role>"
      }
    ]
  }
}
```

### Compute Instance Service Bindings
```json
{
  "locals": {
    "organization_iam": [],
    "project_iam": [],
    "external_project_iam": [],
    "folder_iam": [],
    "resource_iam": [
      {
        "resource_type": "compute_instance_service",
        "name": "<compute-instance-name>",
        "project_id": "<project-id>",
        "role": "<role>"
      }
    ]
  }
}
```

### KMS Crypto Key Bindings
```json
{
  "locals": {
    "organization_iam": [],
    "project_iam": [],
    "external_project_iam": [],
    "folder_iam": [],
    "resource_iam": [
      {
        "resource_type": "kms_crypto_key",
        "location": "<kms-crypto-key-location>",
        "key_ring_name": "kms-key-ring-name",
        "name": "<kms-crypto-key-name>",
        "project_id": "<project-id>",
        "role": "<role>"
      }
    ]
  }
}
```

### KMS Key Ring Bindings
```json
{
  "locals": {
    "organization_iam": [],
    "project_iam": [],
    "external_project_iam": [],
    "folder_iam": [],
    "resource_iam": [
      {
        "resource_type": "kms_key_ring",
        "location": "<kms-key-ring-location>",
        "name": "<kms-key-ring-name>",
        "project_id": "<project-id>",
        "role": "<role>"
      }
    ]
  }
}
```

### Secret Manager Bindings
```json
{
  "locals": {
    "organization_iam": [],
    "project_iam": [],
    "external_project_iam": [],
    "folder_iam": [],
    "resource_iam": [
      {
        "resource_type": "secret_manager_secret",
        "name": "<secret-name>",
        "project_id": "<project-id>",
        "role": "<role>"
      }
    ]
  }
}
```

### Storage Bucket Bindings
```json
{
  "locals": {
    "organization_iam": [],
    "project_iam": [],
    "external_project_iam": [],
    "folder_iam": [],
    "resource_iam": [
      {
        "resource_type": "storage_bucket",
        "name": "<bucket-name>",
        "role": "<role>"
      }
    ]
  }
}
```
### Calling the Module
```hcl
locals {
  bindings_vars = jsondecode(file("${"bindings.json"}"))
}

module "iam_bindings" {
  source = "git@github.com:PrimeReditum/reditum-terraform-modules.git/gcp/iam-bindings?ref=v1.0.0"

  organization_bindings     = locals.binding_vars.organization_iam
  project_bindings          = locals.binding_vars.project_iam
  external_project_bindings = locals.binding_vars.external_project_iam
  folder_bindings           = locals.binding_vars.folder_iam
  resource_bindings         = locals.binding_vars.resource_iam
}
```
