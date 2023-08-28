resource "google_project_service" "activate_apis" {
  count   = length(var.list_apis)
  project = var.project_id
  service = var.list_apis[count.index]
}

resource "google_project_service" "compute_api" {
  project = var.project_id
  service = "compute.googleapis.com"
}

resource "google_compute_project_metadata" "project_metadata" {
  project  = var.project_id
  metadata = var.metadata
  depends_on = [
    google_project_service.compute_api
  ]
}

resource "google_service_account" "terraform_orchestrator" {
  account_id   = "terraform_orchestrator"
  description  = "Terraform orchestrator for managing GCP resources"
  display_name = "Terraform Orchestrator"
  project      = var.project_id
}

resource "google_project_iam_binding" "terraform_orchestrator" {
  project = var.project_id
  role    = "roles/owner"
  members = [
    "serviceAccount:${google_service_account.terraform_orchestrator.email}"
  ]
}

resource "google_storage_bucket" "terraform_tfstate" {
  name                        = "${var.project_name}-tfstate"
  project                     = var.project_id
  labels                      = var.labels
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}

resource "google_storage_bucket_iam_member" "name" {
  bucket = google_storage_bucket.terraform_tfstate.name
  role   = "organizations/833830912735/roles/ReditumIaCStateBucket"
  member = "serviceAccount:${google_service_account.terraform_orchestrator.email}"
}
