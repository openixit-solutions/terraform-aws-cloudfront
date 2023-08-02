output "cloudfront_domain" {
  description = "Domain name of the cloudfront distribution"
  value       = aws_cloudfront_distribution.this.domain_name
}

output "cloudfront_id" {
  description = "ID of the cloudfront distribution"
  value       = aws_cloudfront_distribution.this.id
}

output "cloudfront_oai_arn" {
  description = "A pre-generated ARN for use in S3 bucket policies"
  value       = aws_cloudfront_origin_access_identity.this.iam_arn
}
