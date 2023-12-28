output "state_bucket" {
  description = "Bucket Terraform state name"
  value       = google_storage_bucket.iac_state.name
}

output "state_bucket_self_link" {
  description = "Bucket Terraform state URI"
  value       = google_storage_bucket.iac_state.self_link
}

output "terraform_orchestrator_email" {
  description = "Terraform Orchestrator service account email"
  value       = google_service_account.terraform_orchestrator.email
}
