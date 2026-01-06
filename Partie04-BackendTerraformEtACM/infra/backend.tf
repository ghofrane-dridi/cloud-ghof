terraform {
  backend "s3" {
    bucket       = "ghofrane-terraform-backend-state-2026"   # NOM UNIQUE
    key          = "projetfederateur/terraform.tfstate"
    region       = "eu-north-1"
    encrypt      = true
    use_lockfile = true
  }
}
