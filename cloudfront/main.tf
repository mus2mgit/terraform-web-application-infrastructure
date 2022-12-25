variable "domain_name" {
  type        = string
  description = "The domain name of the CloudFront distribution."
}

variable "origin_id" {
  type        = string
  description = "The ID of the origin to use for the CloudFront distribution."
}

variable "origin_domain_name" {
  type        = string
  description = "The domain name of the origin to use for the CloudFront distribution."
}

variable "origin_path" {
  type        = string
  default     = ""
  description = "The path to use for the origin of the CloudFront distribution."
}

resource "aws_cloudfront_distribution" "distribution" {
  origin {
    domain_name = var.origin_domain_name
    origin_id   = var.origin_id
    path        = var.origin_path
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.origin_id
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  enabled = true

  aliases = [var.domain_name]

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.certificate.arn
    ssl_support_method  = "sni-only"
  }
}

resource "aws_acm_certificate" "certificate" {
  domain_name       = var.domain_name
  validation_method = "DNS"
}

resource "aws_route53_record" "certificate_validation" {
  name    = aws_acm_certificate.certificate.domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.certificate.domain_validation_options.0.resource_record_type
  zone_id = aws_acm_certificate.certificate.domain_validation_options.0.hosted_zone_id
  records = [aws_acm_certificate.certificate.domain_validation_options.0.resource_record_value]
  ttl     = 60
}

output "distribution_id" {
  value = aws_cloudfront_distribution.distribution.id
}

output "domain_name" {
  value = aws_cloudfront_distribution.distribution.domain_name
}
