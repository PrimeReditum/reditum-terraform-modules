variable "organization_bindings" {
  /* Format of input:
      list(object({
        organization_id = string,
        role = string,
        condition = object({
          title = string,
          description = string,
          expression = string
        })
      }))
  */
  type        = any
  description = "An object that contains 'organization_id', 'role' and 'condition' (Optional) fields to specify where to and what permissions are applied for the member"
}

variable "project_bindings" {
  /* Format of input:
      list(object({
        project_id = string,
        role = string,
        condition = object({
          title = string,
          description = string,
          expression = string
        })
      }))
  */
  type        = any
  description = "An object that contains 'project_id', 'role' and 'condition' (Optional) fields to specify where to and what permissions are applied for the member"
}

variable "external_project_bindings" {
  /* Format of input:
      list(object({
        project_id = string,
        role = string,
        condition = object({
          title = string,
          description = string,
          expression = string
        })
      }))
  */
  type        = any
  description = "An object that contains external 'project_id', 'role' and 'condition' (Optional) fields to specify where to and what permissions are applied for the member"
}

variable "folder_bindings" {
  /* Format of input:
      list(object({
        folder_id = string,
        role = string,
        condition = object({
          title = string,
          description = string,
          expression = string
        })
      }))
  */
  type        = any
  description = "An object that contains 'folder_id', 'role' and 'condition' (Optional) fields to specify where to and what permissions are applied for the member"
}

variable "resource_bindings" {
  description = "An object that contains different fields depending on the resource to specify where to and what permissions are applied for the member"
}

variable "member" {
  description = "IAM member identity that will get the bindings to the targed based on binding_mapping"
  type        = string
}
