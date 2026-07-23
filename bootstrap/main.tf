terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # This bootstrap config intentionally uses LOCAL state.
  # It creates the S3 bucket + DynamoDB table that the main-infra
  # project will later use as its remote backend.
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

# --- S3 bucket for Terraform remote state ---
resource "aws_s3_bucket" "tfstate" {
  bucket = var.bucket_name

  tags = {
    Name    = "terraform-state-bucket"
    Project = "devops-iac-lab"
  }
}

resource "aws_s3_bucket_versioning" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# --- DynamoDB table for state locking ---
resource "aws_dynamodb_table" "tf_locks" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name    = "terraform-locks"
    Project = "devops-iac-lab"
  }
}
