resource "aws_s3_bucket" "tm-cloud-resume" {
  bucket = "tm-cloud-resume"
  tags = {
    environment = "labs"
  }
}

resource "aws_s3_account_public_access_block" "tm-cloud-resume" {
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tm-cloud-resume" {
  bucket = aws_s3_bucket.tm-cloud-resume.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }

}


#assigning policy to enable cloudfront to access bucket
resource "aws_s3_bucket_policy" "tm-cloud-resume" {
  depends_on = [
    aws_cloudfront_distribution.Site_Access
  ]
  bucket = aws_s3_bucket.tm-cloud-resume.id
  policy = data.aws_iam_policy_document.tm-cloud-resume.json
}
#Creating policy to allow CloudFront to reach S3 bucket
data "aws_iam_policy_document" "tm-cloud-resume" {
  depends_on = [
    aws_cloudfront_distribution.Site_Access,
    aws_s3_bucket.tm-cloud-resume
  ]
  statement {
    sid    = "3"
    effect = "Allow"
    actions = [
      "s3:GetObject"
    ]
    principals {
      identifiers = ["cloudfront.amazonaws.com"]
      type        = "Service"
    }
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.tm-cloud-resume.bucket}/*"
    ]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"

      values = [
        aws_cloudfront_distribution.Site_Access.arn
      ]
    }
  }
}

#Enabling AWS S3 file versioning
resource "aws_s3_bucket_versioning" "tm-cloud-resume" {
  bucket = aws_s3_bucket.tm-cloud-resume.bucket
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_object" "web_files" {
  for_each = fileset("../my-site", "**/*")

  bucket = aws_s3_bucket.tm-cloud-resume.id 
  key    = each.value
  source = "../my-site/${each.value}"
  etag   = filemd5("../my-site/${each.value}")
}


#Creates CloudFront distribution
resource "aws_cloudfront_distribution" "Site_Access" {
  depends_on = [
    aws_s3_bucket.tm-cloud-resume,
    aws_cloudfront_origin_access_control.Site_Access
  ]

  origin {
    domain_name              = aws_s3_bucket.tm-cloud-resume.bucket_regional_domain_name
    origin_id                = aws_s3_bucket.tm-cloud-resume.id
    origin_access_control_id = aws_cloudfront_origin_access_control.Site_Access.id
  }

  enabled             = true
  default_root_object = "index.html"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "GB"]
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = aws_s3_bucket.tm-cloud-resume.id
    viewer_protocol_policy = "https-only"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }

    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}


# Create Origin Access Control as this is required to allow access to the s3 bucket without public access to the S3 bucket.
resource "aws_cloudfront_origin_access_control" "Site_Access" {
  name                              = "New_Security_Pillar100_CF_S3_OAC"
  description                       = "OAC setup for security pillar 100"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}