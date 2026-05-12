resource "aws_s3_bucket" "data" {
  # bucket is public
  # bucket is not encrypted
  # bucket does not have access logs
  # bucket does not have versioning
  bucket = "${local.resource_prefix.value}-data"
  region = "us-west-2"
  acl    = "public-read"
  #force_destroy = true
  tags = {
    Name        = "${local.resource_prefix.value}-data"
    Environment = local.resource_prefix.value
    git_org     = "try-panwiac"
    git_repo    = "supplygoat"
    yor_trace   = "7c65ac71-1111-4075-9830-bf2a6aaa423f"
  }
}

resource "aws_s3_bucket_object" "data_object" {
  bucket = aws_s3_bucket.data.id
  region = "us-west-2"
  key    = "customer-master.xlsx"
  source = "resources/customer-master.xlsx"
  tags = {
    Name        = "${local.resource_prefix.value}-customer-master"
    Environment = local.resource_prefix.value
    git_org     = "try-panwiac"
    git_repo    = "supplygoat"
    yor_trace   = "59d66882-eb8b-45c3-8ef3-447f2405cb95"
  }
}

resource "aws_s3_bucket" "financials" {
  # bucket is not encrypted
  # bucket does not have access logs
  # bucket does not have versioning
  bucket        = "${local.resource_prefix.value}-financials"
  region        = "us-west-2"
  acl           = "public-read"
  force_destroy = true
  tags = {
    Name        = "${local.resource_prefix.value}-financials"
    Environment = local.resource_prefix.value
    git_org     = "try-panwiac"
    git_repo    = "supplygoat"
    yor_trace   = "35be1604-d635-4ffe-988d-b898263fce82"
  }

}

resource "aws_s3_bucket" "operations" {
  # bucket is not encrypted
  # bucket does not have access logs
  bucket = "${local.resource_prefix.value}-operations"
  region = "us-west-2"
  acl    = "private"
  versioning {
    enabled = true
  }
  force_destroy = true
  tags = {
    Name        = "${local.resource_prefix.value}-operations"
    Environment = local.resource_prefix.value
    git_org     = "try-panwiac"
    git_repo    = "supplygoat"
    yor_trace   = "612ba878-d74e-486c-902d-c8c0143ee576"
  }

}

resource "aws_s3_bucket" "data_science" {
  # bucket is not encrypted
  bucket = "${local.resource_prefix.value}-data-science"
  region = "us-west-2"
  acl    = "private"
  versioning {
    enabled = true
  }
  logging {
    target_bucket = "${aws_s3_bucket.logs.id}"
    target_prefix = "log/"
  }
  force_destroy = true
  tags = {
    git_org   = "try-panwiac"
    git_repo  = "supplygoat"
    yor_trace = "02ec5cf5-c254-4b71-90de-5f0429eb245e"
  }
}

resource "aws_s3_bucket" "logs" {
  bucket = "${local.resource_prefix.value}-logs"
  region = "us-west-2"
  acl    = "log-delivery-write"
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = "${aws_kms_key.logs_key.arn}"
      }
    }
  }
  force_destroy = true
  tags = {
    Name        = "${local.resource_prefix.value}-logs"
    Environment = local.resource_prefix.value
    git_org     = "try-panwiac"
    git_repo    = "supplygoat"
    yor_trace   = "36fa107d-bf72-49bc-b2ad-29df810ea27c"
  }
}
