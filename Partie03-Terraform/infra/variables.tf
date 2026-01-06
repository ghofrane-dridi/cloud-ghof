variable "environment" {
  description = "The environment to deploy the resources to"
  type = map(object({
    project_name = string
    domain_name  = string
    record_name  = string
  }))
}