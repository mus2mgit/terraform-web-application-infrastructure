# Terraform Infrastructure for Static Website

This repository contains Terraform code for creating an infrastructure for a static website hosted on AWS. The infrastructure includes an S3 bucket for storing the website files, a CloudFront distribution for delivering the website, and a Route 53 A record for pointing to the CloudFront distribution.

## Prerequisites

Before using these modules, you will need the following:

- An AWS account with access to create and manage S3, CloudFront, and Route 53 resources.
- [Terraform](https://www.terraform.io/) installed on your local machine.

## Usage

To use these modules, follow these steps:

1. Clone this repository to your local machine.
2. In the `static-website` directory, create a file named `terraform.tfvars` and define the following variables:
   - `bucket_name`: The name of the S3 bucket to create.
3. In the `cloudfront` directory, create a file named `terraform.tfvars` and define the following variables:
   - `domain_name`: The domain name of the CloudFront distribution.
   - `origin_id`: The ID of the S3 bucket to use as the origin for the distribution.
   - `origin_domain_name`: The domain name of the S3 bucket.
4. In the `route53` directory, create a file named `terraform.tfvars` and define the following variables:
   - `hosted_zone_id`: The ID of the Route 53 hosted zone in which to create the A record.
   - `domain_name`: The domain name of the CloudFront distribution.
   - `distribution_id`: The ID of the CloudFront distribution.
5. In each directory, run the following commands to create the infrastructure:
   - `terraform init`
   - `terraform plan`
   - `terraform apply`

## Outputs

The `static-website` module has the following output:

- `website_endpoint`: The endpoint of the S3 bucket website.

The `cloudfront` module has the following outputs:

- `distribution_id`: The ID of the CloudFront distribution.
- `domain_name`: The domain name of the CloudFront distribution.

The `route53` module has no outputs.

## License

This code is released under the MIT License. See [LICENSE](LICENSE) for details.
