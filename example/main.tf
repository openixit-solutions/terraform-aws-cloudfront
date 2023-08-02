terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

resource "random_string" "random" {
  length  = 10
  special = false
  upper   = false
}

resource "aws_s3_bucket" "bucket" {
  bucket        = "s3-example-${random_string.random.id}"
  acl           = "private"
  force_destroy = true

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

module "cloudfront" {
  source = "../"

  bucket_regional_domain = aws_s3_bucket.bucket.bucket_regional_domain_name

  compress            = true
  default_root_object = "/index.html"
  price_class         = "PriceClass_200"

  forward         = "all"
  enabled         = true
  is_ipv6_enabled = true

  custom_error_response = [
    {
      error_code            = 404
      response_code         = 200
      response_page_path    = "/index.html"
      error_caching_min_ttl = 300
    }
  ]

  region = "us-west-2"
}
