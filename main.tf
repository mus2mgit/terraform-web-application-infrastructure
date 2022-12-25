module "static_website" {
  source = "./static-website"

  bucket_name = "my-static-website-bucket"
}

module "cloudfront" {
  source = "./cloudfront"

  domain_name      = "my-static-website.example.com"
  origin_id        = module.static_website.bucket.id
  origin_domain_name = module.static_website.bucket.website_endpoint
}

module "route53" {
  source = "./route53"

  hosted_zone_id = "Z0123456789"
  domain_name    = module.cloudfront.domain_name
  distribution_id = module.cloudfront.distribution_id
}
