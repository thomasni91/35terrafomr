provider "aws" {
  region = var.aws_region
}


resource "aws_s3_bucket" "terraform-state" {
  bucket = var.bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  #   tags = {
  #     project = var.tag_project
  #     environment = var.tag_environemnt
  #   }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.terraform-state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = var.table_name
  #   read_capacity  = 1
  #   write_capacity = 1
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}