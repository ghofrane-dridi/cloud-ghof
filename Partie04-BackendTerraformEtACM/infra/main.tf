#################################
# S3 WEBSITE
#################################
module "s3_website" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "5.2.0"

  bucket        = "${local.env.record_name}.${local.env.domain_name}"
  force_destroy = true

  acl                      = "private"
  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  block_public_acls        = true
  block_public_policy      = false
  ignore_public_acls       = true
  restrict_public_buckets  = true

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  website = {
    index_document = "index.html"
    error_document = "error.html"
  }

  attach_policy = true
  policy        = data.aws_iam_policy_document.example_bucket_policy_document.json
}

#################################
# ROUTE53 ZONE
#################################
data "aws_route53_zone" "zone" {
  name         = local.env.domain_name
  private_zone = false
}

#################################
# ACM CERTIFICATE (us-east-1)
#################################
resource "aws_acm_certificate" "cert" {
  provider          = aws.east
  domain_name       = "${local.env.record_name}.${local.env.domain_name}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

#################################
# DNS VALIDATION RECORD (UNE SEULE RESSOURCE)
#################################
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options :
    dvo.domain_name => dvo
  }

  zone_id = data.aws_route53_zone.zone.zone_id
  name    = each.value.resource_record_name
  type    = each.value.resource_record_type
  ttl     = 60
  records = [each.value.resource_record_value]

  allow_overwrite = true
}

#################################
# CERTIFICATE VALIDATION
#################################
resource "aws_acm_certificate_validation" "cert_validation" {
  provider                = aws.east
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for r in aws_route53_record.cert_validation : r.fqdn]
}
