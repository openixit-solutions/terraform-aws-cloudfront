data "aws_iam_policy_document" "this" {
  count = var.create_bucket_policy ? 1 : 0

  statement {
    actions = ["s3:GetObject"]

    resources = [
      var.bucket_arn,
      "${var.bucket_arn}/*"
    ]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.this.iam_arn]
    }
  }
}

data "aws_route53_zone" "this" {
  count = var.domain_name != null ? 1 : 0
  name  = var.domain_name
}
