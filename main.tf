resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "OAI for website"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_s3_bucket_policy" "this" {
  count = var.create_bucket_policy ? 1 : 0

  bucket = var.bucket_id
  policy = data.aws_iam_policy_document.this[0].json
}

resource "aws_cloudfront_distribution" "this" {
  aliases             = var.aliases
  comment             = var.comment
  default_root_object = var.default_root_object
  enabled             = var.enabled
  http_version        = var.http_version
  is_ipv6_enabled     = var.is_ipv6_enabled
  price_class         = var.price_class
  retain_on_delete    = var.retain_on_delete
  wait_for_deployment = var.wait_for_deployment
  web_acl_id          = var.web_acl_id
  tags                = merge(var.tags, { Terraform = "true" })

  origin {
    domain_name = var.bucket_regional_domain
    origin_id   = var.bucket_regional_domain

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    target_origin_id       = var.bucket_regional_domain
    viewer_protocol_policy = var.viewer_protocol_policy

    allowed_methods           = var.allowed_methods
    cached_methods            = var.cached_methods
    compress                  = var.compress
    field_level_encryption_id = var.field_level_encryption_id
    smooth_streaming          = var.smooth_streaming
    trusted_signers           = var.trusted_signers
    trusted_key_groups        = var.trusted_key_groups


    cache_policy_id            = var.cache_policy_id
    origin_request_policy_id   = var.origin_request_policy_id
    response_headers_policy_id = var.response_headers_policy_id
    realtime_log_config_arn    = var.realtime_log_config_arn

    min_ttl     = var.min_ttl
    default_ttl = var.default_ttl
    max_ttl     = var.max_ttl

    forwarded_values {
      query_string            = var.query_string
      query_string_cache_keys = var.query_string_cache_keys
      headers                 = var.headers

      cookies {
        forward           = var.forward
        whitelisted_names = var.whitelisted_names
      }
    }
  }

  dynamic "custom_error_response" {
    for_each = length(flatten([var.custom_error_response])[0]) > 0 ? flatten([var.custom_error_response]) : []

    content {
      error_code = custom_error_response.value["error_code"]

      response_code         = lookup(custom_error_response.value, "response_code", null)
      response_page_path    = lookup(custom_error_response.value, "response_page_path", null)
      error_caching_min_ttl = lookup(custom_error_response.value, "error_caching_min_ttl", null)
    }
  }

  restrictions {
    dynamic "geo_restriction" {
      for_each = [var.geo_restriction]

      content {
        restriction_type = lookup(geo_restriction.value, "restriction_type", "none")
        locations        = lookup(geo_restriction.value, "locations", [])
      }
    }
  }

  viewer_certificate {
    acm_certificate_arn            = lookup(var.viewer_certificate, "acm_certificate_arn", null)
    cloudfront_default_certificate = lookup(var.viewer_certificate, "cloudfront_default_certificate", null)
    iam_certificate_id             = lookup(var.viewer_certificate, "iam_certificate_id", null)

    minimum_protocol_version = lookup(var.viewer_certificate, "minimum_protocol_version", "TLSv1")
    ssl_support_method       = lookup(var.viewer_certificate, "ssl_support_method", null)
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "this" {
  for_each = toset(var.aliases)

  name    = each.key
  zone_id = data.aws_route53_zone.this[0].zone_id
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
    evaluate_target_health = true
  }
}
