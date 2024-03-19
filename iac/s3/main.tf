

resource "aws_s3_bucket" "tm-cloud-resume" {
    bucket = "tm-cloud-resume" 
    tags = {
        environment = "labs"
    }   
}

resource "aws_s3_account_public_access_block" "tm-cloud-resume" {
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
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

resource "aws_s3_bucket_versioning" "tm-cloud-resume" {
    bucket = aws_s3_bucket.tm-cloud-resume.bucket
    versioning_configuration {
      status = "Enabled"
    }
  
}
