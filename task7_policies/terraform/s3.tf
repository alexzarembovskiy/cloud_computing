## S3 PART

resource "aws_s3_bucket" "consume-bucket" {
  bucket = "consume-bucket"

  block_public_acls   = true
  block_public_policy = true

  versioning {
    enabled    = true
  }
}