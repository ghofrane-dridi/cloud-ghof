variable "environment" {
  description = "Environments configuration"
  type = map(object({
    project_name = string
    domain_name  = string
    record_name  = string
  }))
}
