output "state_bucket" {
  description = "Bucket Terraform state name"
  value       = google_storage_bucket.terraform_tfstate.name
}

output "state_bucket_self_link" {
  description = "Bucket Terraform state URI"
  value       = google_storage_bucket.terraform_tfstate.self_link
}
