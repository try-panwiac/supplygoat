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
    yor_trace   = "5bb30f7a-04f6-4e67-b23a-83044256e06a"
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
    yor_trace   = "6da435a7-2eb8-448e-ab1a-258316de9401"
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
    yor_trace   = "74e50846-1c4f-428f-9e1d-fa1e1c6166a0"
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
    yor_trace   = "879f57de-4baf-4a91-a02c-d1f5a88dfbaa"
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
    yor_trace = "ee495f53-7ebd-4148-9e3c-552dce034721"
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
    yor_trace   = "98658a56-5228-42d7-a5a9-65d3d9b7dfa3"
  }
}
