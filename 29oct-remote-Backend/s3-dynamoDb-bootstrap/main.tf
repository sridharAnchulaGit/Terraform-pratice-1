provider "aws" {
    region = "us-east-1"
}

resource "aws_s3_bucket" "terrafrom_state" {
    bucket = "sridharr-anchulaa-buckets-2026"
    tags = {
      Name="sridhar-anchula-bucket-2026"
    }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
    bucket = aws_s3_bucket.terrafrom_state.id
    versioning_configuration {
      status = "Enabled"
    }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
    bucket = aws_s3_bucket.terrafrom_state.id
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
}

resource "aws_s3_bucket_public_access_block" "terraform_state" {
    bucket = aws_s3_bucket.terrafrom_state.id

    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}

#creating dynamodb
resource "aws_dynamodb_table" "terraform_state" {
    name = "terraform-state-lock"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"

    attribute {
      name = "LockID"
      type = "S"
    }
   tags = {
     Name="terraform-state-lock"
   }
}