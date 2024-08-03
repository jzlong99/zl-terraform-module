# Purpose: Define the output variables for the S3 bucket module.

output "name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.s3_bucket_object.id
}

output "arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.s3_bucket_object.arn
}

output "region" {
  description = "The AWS region where the S3 bucket is located"
  value       = aws_s3_bucket.s3_bucket_object.region
}

output "bucket_domain_name" {
  description = "The bucket domain name of the S3 bucket"
  value       = aws_s3_bucket.s3_bucket_object.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "The bucket regional domain name of the S3 bucket"
  value       = aws_s3_bucket.s3_bucket_object.bucket_regional_domain_name
}

output "tags" {
  description = "The tags assigned to the S3 bucket"
  value       = aws_s3_bucket.s3_bucket_object.tags

  precondition {
    condition     = aws_s3_bucket.s3_bucket_object.tags
    error_message = "The S3 bucket does not have any tags assigned to it"
  }
}

output "id" {
  description = "The ID of the S3 bucket"
  value       = aws_s3_bucket_object_lock_configuration.s3_bucket_object_lock_object.id
}
