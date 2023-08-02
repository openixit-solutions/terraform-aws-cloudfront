# CloudFront

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | Region for Resources | `string` | n/a | yes |
| <a name="input_bucket_regional_domain"></a> [s3_bucket_regional_domain](#input\_bucket_name) | Name of the bucket | `string` | `null` | no |
| <a name="input_bucket_arn"></a> [s3_bucket_arn](#input\_s3_bucket_arn) | The ARN of the bucket. Will be of format arn:aws:s3:::bucketname | `string` | `null` | no |
| <a name="input_bucket_id"></a> [s3_regional_id](#input\_s3_bucket_id) | ID of the bucket | `string` | `null` | no |
| <a name="input_create_bucket_policy"></a> [create_bucket_policy](#input\_create_bucket_policy) | Enable creation of bucket policy | `bool` | `false` | no |
| <a name="input_aliases"></a> [aliases](#input\_aliases) | Extra CNAMEs (alternate domain names), if any, for this distribution | `list(string)` | `[]` | no |
| <a name="input_domain_name"></a> [domain_name](#input\_domain_name) | Hosted Zone name of the desired Hosted Zone | `string` | `null` | no |
| <a name="input_comment"></a> [comment](#input\_comment) | Any comments you want to include about the distribution | `string` | `null` | no |
| <a name="input_default_root_object"></a> [default_root_object](#input\_default_root_object) | The object that you want CloudFront to return (for example, index.html) when an end user requests the root URL | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether the distribution is enabled to accept end user requests for content | `bool` | `true` | no |
| <a name="input_http_version"></a> [http_version](#input\_http_version) | The maximum HTTP version to support on the distribution. Allowed values are http1.1, http2, http2and3, and http3. The default is http2 | `string` | `http2` | no |
| <a name="input_is_ipv6_enabled"></a> [is_ipv6_enabled](#input\_is_ipv6_enabled) | Whether the IPv6 is enabled for the distribution | `bool` | `null` | no |
| <a name="input_price_class"></a> [price_class](#input\_price_class) | The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100 | `string` | `null` | no |
| <a name="input_retain_on_delete"></a> [retain_on_delete](#input\_retain_on_delete) | Disables the distribution instead of deleting it when destroying the resource through Terraform. If this is set, the distribution needs to be deleted manually afterwards | `bool` | `false` | no |
| <a name="input_wait_for_deployment"></a> [wait_for_deployment](#input\_wait_for_deployment) | If enabled, the resource will wait for the distribution status to change from InProgress to Deployed. Setting this to false will skip the process | `bool` | `true` | no |
| <a name="input_web_acl_id"></a> [web_acl_id](#input\_web_acl_id) | If you're using AWS WAF to filter CloudFront requests, the Id of the AWS WAF web ACL that is associated with the distribution. The WAF Web ACL must exist in the WAF Global (CloudFront) region and the credentials configuring this argument must have waf:GetWebACL permissions assigned. If using WAFv2, provide the ARN of the web ACL | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resource | `map(string)` | `{}` | no |
| <a name="input_custom_error_response"></a> [custom_error_response](#input\_custom_error_response) | One or more custom error response elements | `any` | `{}` | no |
| <a name="input_geo_restriction"></a> [geo_restriction](#input\_geo_restriction) | The restriction configuration for this distribution (geo_restrictions) | `any` | `{}` | no |
| <a name="input_viewer_certificate"></a> [viewer_certificate](#input\_viewer_certificate) | The SSL configuration for this distribution | `any` | <pre>{<br>  cloudfront_default_certificate = true <br>  minimum_protocol_version = "TLSv1" <br> }</pre> | no |
| <a name="input_viewer_protocol_policy"></a> [viewer_protocol_policy](#input\_viewer_protocol_policy) | Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern. One of allow-all, https-only, or redirect-to-https | `string` | `redirect-to-https` | no |
| <a name="input_allowed_methods"></a> [allowed_methods](#input\_allowed_methods) | Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin | `list(string)` | `["GET", "HEAD", "OPTIONS"]` | no |
| <a name="input_cached_methods"></a> [cached_methods](#input\_cached_methods) | Controls whether CloudFront caches the response to requests using the specified HTTP methods | `list(string)` | `["GET", "HEAD"]` | no |
| <a name="input_compress"></a> [compress](#input\_compress) | Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header (default: false) | `bool` | `false` | no |
| <a name="input_field_level_encryption_id"></a> [field_level_encryption_id](#input\_field_level_encryption_id) | Field level encryption configuration ID | `string` | `null` | no |
| <a name="input_smooth_streaming"></a> [smooth_streaming](#input\_smooth_streaming) | Indicates whether you want to distribute media files in Microsoft Smooth Streaming format using the origin that is associated with this cache behavior | `string` | `null` | no |
| <a name="input_trusted_signers"></a> [trusted_signers](#input\_trusted_signers) | List of AWS account IDs (or self) that you want to allow to create signed URLs for private content | `list(string)` | `null` | no |
| <a name="input_trusted_key_groups"></a> [trusted_key_groups](#input\_trusted_key_groups) | List of key group IDs that CloudFront can use to validate signed URLs or signed cookies | `list(string)` | `null` | no |
| <a name="input_cache_policy_id"></a> [cache_policy_id](#input\_cache_policy_id) | Unique identifier of the cache policy that is attached to the cache behavior. If configuring the default_cache_behavior either cache_policy_id or forwarded_values must be set | `string` | `null` | no |
| <a name="input_origin_request_policy_id"></a> [origin_request_policy_id](#input\_origin_request_policy_id) | Unique identifier of the origin request policy that is attached to the behavior | `string` | `null` | no |
| <a name="input_response_headers_policy_id"></a> [response_headers_policy_id](#input\_response_headers_policy_id) | Identifier for a response headers policy | `string` | `null` | no |
| <a name="input_realtime_log_config_arn"></a> [realtime_log_config_arn](#input\_realtime_log_config_arn) | ARN of the real-time log configuration that is attached to this cache behavior | `string` | `null` | no |
| <a name="input_min_ttl"></a> [min_ttl](#input\_min_ttl) | Minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated | `number` | `0` | no |
| <a name="input_default_ttl"></a> [default_ttl](#input\_default_ttl) | Default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header | `number` | `300` | no |
| <a name="input_max_ttl"></a> [max_ttl](#input\_max_ttl) | Maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated | `number` | `3600` | no |
| <a name="input_query_string"></a> [query_string](#input\_query_string) | Indicates whether you want CloudFront to forward query strings to the origin that is associated with this cache behavior | `bool` | `true` | no |
| <a name="input_query_string_cache_keys"></a> [query_string_cache_keys](#input\_query_string_cache_keys) | When specified, along with a value of true for query_string, all query strings are forwarded, however only the query string keys listed in this argument are cached. When omitted with a value of true for query_string, all query string keys are cached | `list(string)` | `[]` | no |
| <a name="input_headers"></a> [headers](#input\_headers) | Headers, if any, that you want CloudFront to vary upon for this cache behavior. Specify * to include all headers | `list(string)` | `[]` | no |
| <a name="input_forward"></a> [forward](#input\_forward) | Whether you want CloudFront to forward cookies to the origin that is associated with this cache behavior. You can specify all, none or whitelist. If whitelist, you must include the subsequent whitelisted_names | `string` | `none` | no |
| <a name="input_whitelisted_names"></a> [whitelisted_names](#input\_whitelisted_names) | If you have specified whitelist to forward, the whitelisted cookies that you want CloudFront to forward to your origin | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudfront_domain"></a> [cloudfront\_domain](#output\_cloudfront\_domain) | The domain name corresponding to the distribution. Will be of format *random-string*.cloudfront.net |
| <a name="output_cloudfront_id"></a> [cloudfront\_id](#output\_cloudfront\_id) | The ID corresponding to the distribution |
| <a name="cloudfront_oai_arn"></a> [cloudfront\_oai\_arn](#output\_cloudfront\_oai\_arn) | A pre-generated ARN for use in S3 bucket policies |
