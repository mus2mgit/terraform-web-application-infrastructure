variable "hosted_zone_id" {
  type        = string
  description = "The ID of the Route 53 hosted zone in which to create the A record."
}

variable "domain_name" {
  type        = string
  description = "The domain name of the CloudFront distribution."
}

variable "distribution_id" {
  type        = string
  description = "The ID of the CloudFront distribution."
}

resource "aws_route53_record" "a_record" {
  zone_id = var.hosted_zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.domain_name
    zone_id                = var.hosted_zone_id
    evaluate_target_health = true
    target_dns_name        = aws_cloudfront_distribution.distribution.domain_name
    target_evaluate_health = true
  }
}

resource "aws_cloudfront_distribution" "distribution" {
  id = var.distribution_id
}
