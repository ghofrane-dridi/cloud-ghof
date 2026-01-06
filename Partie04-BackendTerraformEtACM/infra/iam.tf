data "aws_iam_policy_document" "example_bucket_policy_document" {
  statement {
    sid    = "PublicReadGetObject"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:PutObjectAcl",
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::${local.env.record_name}.${local.env.domain_name}",
      "arn:aws:s3:::${local.env.record_name}.${local.env.domain_name}/*"
    ]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}
