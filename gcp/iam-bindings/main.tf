/**************************************
  External Project IAM binding additive
***************************************/
resource "google_project_iam_member" "external_project_iam_additive" {
  for_each = {
    for index, binding in var.external_project_bindings :
    index => binding
  }
  project = each.value.project_id
  role    = each.value.role
  member  = var.member
  dynamic "condition" {
    for_each = each.value.condition == {} ? [] : [each.value.condition]
    content {
      title       = each.value.condition.title
      description = each.value.condition.description
      expression  = each.value.condition.expression
    }
  }
}

/**************************************
  Folder IAM binding additive
***************************************/
resource "google_folder_iam_member" "folder_iam_additive" {
  for_each = {
    for index, binding in var.folder_bindings :
    index => binding
  }
  folder = each.value.folder_id
  role   = each.value.role
  member = var.member
  dynamic "condition" {
    for_each = each.value.condition == {} ? [] : [each.value.condition]
    content {
      title       = each.value.condition.title
      description = each.value.condition.description
      expression  = each.value.condition.expression
    }
  }
}

/**************************************
  Organization IAM binding additive
***************************************/
resource "google_organization_iam_member" "organization_iam_additive" {
  for_each = {
    for index, binding in var.organization_bindings :
    index => binding
  }
  org_id = each.value.org_id
  role   = each.value.role
  member = var.member
  dynamic "condition" {
    for_each = each.value.condition == {} ? [] : [each.value.condition]
    content {
      title       = each.value.condition.title
      description = each.value.condition.description
      expression  = each.value.condition.expression
    }
  }
}

/**************************************
  Project IAM binding additive
***************************************/
resource "google_project_iam_member" "project_iam_additive" {
  for_each = {
    for index, binding in var.project_bindings :
    index => binding
  }
  project = each.value.project_id
  role    = each.value.role
  member  = var.member
  dynamic "condition" {
    for_each = each.value.condition == {} ? [] : [each.value.condition]
    content {
      title       = each.value.condition.title
      description = each.value.condition.description
      expression  = each.value.condition.expression
    }
  }
}

/**************************************
  Resource IAM binding additive
  Exhaustive list taken from available resource IAM modules in:
  https://github.com/terraform-google-modules/terraform-google-iam/tree/master/modules
***************************************/

resource "google_cloud_run_service_iam_member" "cloud_run_iam_additive" {
  for_each = {
    for binding in var.resource_bindings : "${binding.name}.${binding.role}" => binding
    if binding.resource_type == "cloud_run_service"
  }
  location = each.value.location
  member   = var.member
  project  = each.value.project_id
  role     = each.value.role
  service  = each.value.name
}

resource "google_kms_crypto_key_iam_member" "kms_crypto_key_iam_additive" {
  for_each = {
    for binding in var.resource_bindings : "${binding.name}.${binding.role}" => binding
    if binding.resource_type == "kms_crypto_key"
  }
  crypto_key_id = "${each.value.project_id}/${each.value.location}/${each.value.key_ring_name}/${each.value.name}"
  member        = var.member
  role          = each.value.role
}

resource "google_kms_key_ring_iam_member" "kms_key_ring_iam_additive" {
  for_each = {
    for binding in var.resource_bindings : "${binding.name}.${binding.role}" => binding
    if binding.resource_type == "kms_key_ring"
  }
  key_ring_id = "${each.value.project_id}/${each.value.location}/${each.value.name}"
  member      = var.member
  role        = each.value.role
}

resource "google_secret_manager_secret_iam_member" "secret_manager_iam_additive" {
  for_each = {
    for binding in var.resource_bindings : "${binding.name}.${binding.role}" => binding
    if binding.resource_type == "secret_manager_secret"
  }
  member    = var.member
  project   = each.value.project_id
  role      = each.value.role
  secret_id = each.value.name
}

resource "google_storage_bucket_iam_member" "storage_bucket_iam_additive" {
  for_each = {
    for binding in var.resource_bindings : "${binding.name}.${binding.role}" => binding
    if binding.resource_type == "storage_bucket"
  }
  bucket = each.value.name
  member = var.member
  role   = each.value.role
}
