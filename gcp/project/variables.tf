variable "project_id" {
  default     = ""
  description = "Project ID"
  type        = string
}

variable "labels" {
  description = "Map of labels for project"
  default     = {}
  type        = map(string)
}

variable "list_apis" {
  description = "List of APIs to be enabled in the project"
  type        = list(string)
}

variable "metadata" {
  description = "Map of project metadata values"
  default     = {}
  type        = map(string)
}
