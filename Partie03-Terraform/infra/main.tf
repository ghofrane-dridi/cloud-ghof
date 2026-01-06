module "s3_bucket_for_website_hosting" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "5.2.0"

  # Nom du bucket = record_name.domain_name
  # Exemple : profile.ghofrane-cloud.me
  bucket = "${local.env.record_name}.${local.env.domain_name}"

  acl                 = "private"
  object_lock_enabled = true
  force_destroy       = true

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  # Sécurité
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
  attach_policy           = true


  # Chiffrement
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  # Hébergement Web Statique
  website = {
    index_document = "index.html"
    error_document = "error.html"
  }

  # Politique IAM
  policy = data.aws_iam_policy_document.example_bucket_policy_document.json
}
