variable "project_id" {
  default     = ""
  description = "Project ID"
  type        = string
}
######################
# IMPORTANT
# Only hyphens (-), underscores (_), lowercase characters, and numbers are allowed
variable "labels" {
  description = "Map of labels for project"
  default     = {}
  type        = map(string)
}

variable "list_apis" {
  description = "List of APIs to be enabled in the project"
  type        = list(string)
}
