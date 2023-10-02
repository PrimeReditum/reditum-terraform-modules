resource "google_compute_project_metadata" "compute_metadata" {
  depends_on = [google_project_service.compute_api]
  metadata = {
    enable-oslogin = "TRUE"
  }
  project = var.project_id
}

resource "google_project_service" "activate_apis" {
  count                      = length(var.list_apis)
  project                    = var.project_id
  disable_dependent_services = true
  service                    = var.list_apis[count.index]
}

resource "google_project_service" "compute_api" {
  project = var.project_id
  service = "compute.googleapis.com"
}

resource "google_service_account" "terraform_orchestrator" {
  account_id   = "terraform-orchestrator"
  description  = "Terraform orchestrator for managing GCP resources"
  display_name = "Terraform Orchestrator"
  project      = var.project_id
}

resource "google_storage_bucket" "iac_state" {
  name                        = "${var.project_id}-tfstate"
  project                     = var.project_id
  labels                      = var.labels
  location                    = "US-CENTRAL1"
  uniform_bucket_level_access = true
  storage_class               = "STANDARD"

  versioning {
    enabled = true
  }
}

resource "google_storage_bucket_iam_member" "iac_state" {
  bucket = google_storage_bucket.iac_state.name
  role   = "organizations/833830912735/roles/ReditumIaCStateBucket"
  member = "serviceAccount:${google_service_account.terraform_orchestrator.email}"
}
