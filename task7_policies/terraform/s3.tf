## S3 PART

resource "aws_s3_bucket" "consume-bucket" {
  bucket = "consume-bucket"

  versioning {
    enabled    = true
  }
}

resource "aws_s3_bucket_public_access_block" "access_good_1" {
  bucket = aws_s3_bucket.consume-bucket.id

  block_public_acls   = true
  block_public_policy = true
}