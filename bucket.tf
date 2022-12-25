variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket."
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  website {
    index_document = "index.html"
  }

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicRead",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${var.bucket_name}/*"
    }
  ]
}
EOF
}
