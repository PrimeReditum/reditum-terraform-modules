# Google IAM Custom Terraform Modules

This is a collection of resources that make it easier to non-destructively manage multiple IAM roles for resources on GCP

## Compatibility
This module is mant for use with Terraform 1.0+

## IAM Bindings
You can choose the following resource types to apply in the IAM bindings:

- Projects and external bindings (`projects` variable)
- Organizations(`organizations` variable)
- Folders (`folders` variable)
- Cloud Run Service (`cloud_run_service` variable)
- Compute Instance (`compute_instance_service` variable)
- Kms Crypto Keys (`kms_crypto_key` variable)
- Kms Key Rings (`kms_key_ring` variable)
- Secret Manager Secrets (`secret_manager_secret` variable)
- Storage buckets (`storage_bucket` variable)

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
    "external_project_iam": [],
    "folder_iam": [],
    "organization_iam": [
      {
        "condition": {
          "description": "<description>",
          "expression": "<expression>",
          "title": "<title>"
        },
        "organization_id": "<organization-id>",
        "role": "<role>"
      }
    ],
    "project_iam": [],
    "resource_iam": []
  }
}
```

### Project Bindings
```json
{
  "locals": {
    "external_project_iam": [],
    "folder_iam": [],
    "organization_iam": [],
    "project_iam": [
      {
        "condition": {
          "description": "<description>",
          "expression": "<expression>",
          "title": "<title>"
        },
        "project_id": "<project-id>",
        "role": "<role>"
      }
    ],
    "resource_iam": []
  }
}
```

### External Project Bindings
```json
{
  "locals": {
    "external_project_iam": [
      {
        "condition": {
          "description": "<description>",
          "expression": "<expression>",
          "title": "<title>"
        },
        "project_id": "<project-id>",
        "role": "<role>"
      }
    ],
    "folder_iam": [],
    "organization_iam": [],
    "project_iam": [],
    "resource_iam": []
  }
}
```

### Folder Bindings
```json
{
  "locals": {
    "external_project_iam": [],
    "folder_iam": [
      {
        "condition": {
          "description": "<description>",
          "expression": "<expression>",
          "title": "<title>"
        },
        "folder_id": "<folder-id>",
        "role": "<role>"
      }
    ],
    "organization_iam": [],
    "project_iam": [],
    "resource_iam": []
  }
}
```

### Cloud Run Service Bindings
```json
{
  "locals": {
    "external_project_iam": [],
    "folder_iam": [],
    "organization_iam": [],
    "project_iam": [],
    "resource_iam": [
      {
        "location": "<cloud-run-service-location>",
        "name": "<cloud-run-service-name>",
        "project_id": "<project-id>",
        "resource_type": "cloud_run_service",
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
    "external_project_iam": [],
    "folder_iam": [],
    "organization_iam": [],
    "project_iam": [],
    "resource_iam": [
      {
        "name": "<compute-instance-name>",
        "project_id": "<project-id>",
        "resource_type": "compute_instance_service",
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
    "external_project_iam": [],
    "folder_iam": [],
    "organization_iam": [],
    "project_iam": [],
    "resource_iam": [
      {
        "key_ring_name": "<kms-key-ring-name>",
        "location": "<kms-crypto-key-location>",
        "name": "<kms-crypto-key-name>",
        "project_id": "<project-id>",
        "resource_type": "kms_crypto_key",
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
    "external_project_iam": [],
    "folder_iam": [],
    "organization_iam": [],
    "project_iam": [],
    "resource_iam": [
      {
        "location": "<kms-key-ring-location>",
        "name": "<kms-key-ring-name>",
        "project_id": "<project-id>",
        "resource_type": "kms_key_ring",
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
    "external_project_iam": [],
    "folder_iam": [],
    "organization_iam": [],
    "project_iam": [],
    "resource_iam": [
      {
        "name": "<secret-name>",
        "project_id": "<project-id>",
        "resource_type": "secret_manager_secret",
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
    "external_project_iam": [],
    "folder_iam": [],
    "organization_iam": [],
    "project_iam": [],
    "resource_iam": [
      {
        "name": "<bucket-name>",
        "resource_type": "storage_bucket",
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
