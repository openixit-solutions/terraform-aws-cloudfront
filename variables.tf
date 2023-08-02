variable "region" {
  description = "Region of the resources"
  type        = string
}

variable "bucket_regional_domain" {
  description = "Regional domain of the s3 bucket"
  type        = string
  default     = null
}

variable "bucket_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname"
  type        = string
  default     = null
}

variable "bucket_id" {
  description = "ID of the bucket"
  type        = string
  default     = null
}

variable "create_bucket_policy" {
  description = "Enable creation of bucket policy"
  type        = bool
  default     = false
}

variable "aliases" {
  description = "Extra CNAMEs (alternate domain names), if any, for this distribution"
  type        = list(string)
  default     = []
}

variable "domain_name" {
  description = "Hosted Zone name of the desired Hosted Zone"
  type        = string
  default     = null
}

variable "comment" {
  description = "Any comments you want to include about the distribution"
  type        = string
  default     = null
}

variable "default_root_object" {
  description = "The object that you want CloudFront to return (for example, index.html) when an end user requests the root URL"
  type        = string
  default     = null
}

variable "enabled" {
  description = "Whether the distribution is enabled to accept end user requests for content"
  type        = bool
  default     = true
}

variable "http_version" {
  description = "The maximum HTTP version to support on the distribution. Allowed values are http1.1, http2, http2and3, and http3. The default is http2"
  type        = string
  default     = "http2"
}

variable "is_ipv6_enabled" {
  description = "Whether the IPv6 is enabled for the distribution"
  type        = bool
  default     = null
}

variable "price_class" {
  description = "The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100"
  type        = string
  default     = null
}

variable "retain_on_delete" {
  description = "Disables the distribution instead of deleting it when destroying the resource through Terraform. If this is set, the distribution needs to be deleted manually afterwards"
  type        = bool
  default     = false
}

variable "wait_for_deployment" {
  description = "If enabled, the resource will wait for the distribution status to change from InProgress to Deployed. Setting this to false will skip the process"
  type        = bool
  default     = true
}

variable "web_acl_id" {
  description = "If you're using AWS WAF to filter CloudFront requests, the Id of the AWS WAF web ACL that is associated with the distribution. The WAF Web ACL must exist in the WAF Global (CloudFront) region and the credentials configuring this argument must have waf:GetWebACL permissions assigned. If using WAFv2, provide the ARN of the web ACL"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "custom_error_response" {
  description = "One or more custom error response elements"
  type        = any
  default     = {}
}

variable "geo_restriction" {
  description = "The restriction configuration for this distribution (geo_restrictions)"
  type        = any
  default     = {}
}

variable "viewer_certificate" {
  description = "The SSL configuration for this distribution"
  type        = any
  default = {
    cloudfront_default_certificate = true
    minimum_protocol_version       = "TLSv1"
  }
}

variable "viewer_protocol_policy" {
  description = "Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern. One of allow-all, https-only, or redirect-to-https"
  type        = string
  default     = "redirect-to-https"
}

variable "allowed_methods" {
  description = "Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin"
  type        = list(string)
  default     = ["GET", "HEAD", "OPTIONS"]
}

variable "cached_methods" {
  description = "Controls whether CloudFront caches the response to requests using the specified HTTP methods"
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "compress" {
  description = "Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header (default: false)"
  type        = bool
  default     = false
}

variable "field_level_encryption_id" {
  description = "Field level encryption configuration ID"
  type        = string
  default     = null
}

variable "smooth_streaming" {
  description = "Indicates whether you want to distribute media files in Microsoft Smooth Streaming format using the origin that is associated with this cache behavior"
  type        = string
  default     = null
}

variable "trusted_signers" {
  description = "List of AWS account IDs (or self) that you want to allow to create signed URLs for private content"
  type        = list(string)
  default     = null
}

variable "trusted_key_groups" {
  description = "List of key group IDs that CloudFront can use to validate signed URLs or signed cookies"
  type        = list(string)
  default     = null
}

variable "cache_policy_id" {
  description = "Unique identifier of the cache policy that is attached to the cache behavior. If configuring the default_cache_behavior either cache_policy_id or forwarded_values must be set"
  type        = string
  default     = null
}

variable "origin_request_policy_id" {
  description = "Unique identifier of the origin request policy that is attached to the behavior"
  type        = string
  default     = null
}

variable "response_headers_policy_id" {
  description = "Identifier for a response headers policy"
  type        = string
  default     = null
}

variable "realtime_log_config_arn" {
  description = "ARN of the real-time log configuration that is attached to this cache behavior"
  type        = string
  default     = null
}

variable "min_ttl" {
  description = "Minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated"
  type        = number
  default     = 0
}

variable "default_ttl" {
  description = "Default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header"
  type        = number
  default     = 300
}

variable "max_ttl" {
  description = "Maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated"
  type        = number
  default     = 3600
}

variable "query_string" {
  description = "Indicates whether you want CloudFront to forward query strings to the origin that is associated with this cache behavior"
  type        = bool
  default     = true
}

variable "query_string_cache_keys" {
  description = "When specified, along with a value of true for query_string, all query strings are forwarded, however only the query string keys listed in this argument are cached. When omitted with a value of true for query_string, all query string keys are cached"
  type        = list(string)
  default     = []
}

variable "headers" {
  description = "Headers, if any, that you want CloudFront to vary upon for this cache behavior. Specify * to include all headers"
  type        = list(string)
  default     = []
}

variable "forward" {
  description = "Whether you want CloudFront to forward cookies to the origin that is associated with this cache behavior. You can specify all, none or whitelist. If whitelist, you must include the subsequent whitelisted_names"
  type        = string
  default     = "none"
}

variable "whitelisted_names" {
  description = "If you have specified whitelist to forward, the whitelisted cookies that you want CloudFront to forward to your origin"
  type        = any
  default     = null
}
