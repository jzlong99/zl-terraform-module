# Purpose: Define the output variables for the S3 bucket module.

output "name" {
  description = "Name of the S3 bucket"
  value       = try(aws_s3_bucket.s3_bucket_object[0].id, null)
}

output "arn" {
  description = "The ARN of the S3 bucket"
  value       = try(aws_s3_bucket.s3_bucket_object[0].arn, null)
}

output "region" {
  description = "The AWS region where the S3 bucket is located"
  value       = try(aws_s3_bucket.s3_bucket_object[0].region, null)
}

output "bucket_domain_name" {
  description = "The bucket domain name of the S3 bucket"
  value       = try(aws_s3_bucket.s3_bucket_object[0].bucket_domain_name, null)
}

output "bucket_regional_domain_name" {
  description = "The bucket regional domain name of the S3 bucket"
  value       = try(aws_s3_bucket.s3_bucket_object[0].bucket_regional_domain_name, null)
}

output "tags" {
  description = "The tags assigned to the S3 bucket"
  value       = try(aws_s3_bucket.s3_bucket_object[0].tags, null)
}

output "id" {
  description = "The ID of the S3 bucket"
  value       = try(aws_s3_bucket_object_lock_configuration.s3_bucket_object_lock_object[0].id, null)
}
