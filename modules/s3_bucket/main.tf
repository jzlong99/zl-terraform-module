# Resource to create a S3 bucket.
resource "aws_s3_bucket" "s3_bucket_object" {
  # If the create_bucket is set to true, then create the S3 bucket. Else, don't create the S3 bucket.
  count = var.create_bucket ? 1 : 0

  bucket        = var.bucket_name
  force_destroy = var.force_destroy
  tags          = var.tags
}

# Resource to create a S3 bucket object lock configuration.
resource "aws_s3_bucket_object_lock_configuration" "s3_bucket_object_lock_object" {
  # If the object_lock_enabled is set to true, then create the S3 bucket object lock configuration. Else, don't create the S3 bucket object lock configuration.
  count = var.object_lock_enabled ? 1 : 0

  bucket                = aws_s3_bucket.s3_bucket_object.id
  expected_bucket_owner = var.expected_bucket_owner

  dynamic "rule" {
    for_each = var.rules != null ? [var.rules] : []

    content {
      default_retention {
        mode = rules.value.mode
        days = rules.value.days
      }
    }
  }
}


resource "aws_s3_bucket_lifecycle_configuration" "s3_bucket_lifecycle_configuration_object" {
  # If the lifecycle_configuration_enabled is set to true, then create the S3 bucket lifecycle configuration. Else, don't create the S3 bucket lifecycle configuration.
  count = var.lifecycle_configuration_enabled ? 1 : 0

  bucket                = aws_s3_bucket.s3_bucket_object.id
  expected_bucket_owner = var.expected_bucket_owner

  dynamic "rule" {
    for_each = var.lifecycle_configuration_rules != null ? [var.lifecycle_configuration_rules] : []

    content {
      id     = rule.value.id
      status = try(rule.value.status, "Disabled")

      dynamic "filter" {
        for_each = rule.value.filter != null ? [rule.value.filter] : []

        content {
          prefix                   = rule.value.filter.prefix
          object_size_greater_than = try(rule.value.filter.object_size_greater_than, null)
          object_size_less_than    = try(rule.value.filter.object_size_less_than, null)

          dynamic "and" {
            for_each = rule.value.filter.and != null ? rule.value.filter.and : []

            content {
              prefix                   = rule.value.filter.and.prefix
              object_size_greater_than = try(rule.value.filter.and.object_size_greater_than, null)
              object_size_less_than    = try(rule.value.filter.and.object_size_less_than, null)
            }
          }
        }
      }

      dynamic "abort_incomplete_multipart_upload" {
        for_each = rule.value.abort_incomplete_multipart_upload != null ? [rule.value.abort_incomplete_multipart_upload] : []

        content {
          days_after_initiation = rule.value.abort_incomplete_multipart_upload.days_after_initiation
        }
      }

      dynamic "transition" {
        for_each = rule.value.transition != null ? [rule.value.transition] : []

        content {
          days          = transition.value.days
          storage_class = transition.value.storage_class
        }
      }

      dynamic "expiration" {
        for_each = rule.value.expiration != null ? [rule.value.expiration] : []

        content {
          days = expiration.value.days
        }
      }

      dynamic "noncurrent_version_expiration" {
        for_each = rule.value.noncurrent_version_expiration != null ? [rule.value.noncurrent_version_expiration] : []

        content {
          noncurrent_days = noncurrent_version_expiration.value.noncurrent_days
        }
      }

      dynamic "transition" {
        for_each = rule.value.transition != null ? [rule.value.transition] : []

        content {
          days          = transition.value.days
          date          = transition.value.date
          storage_class = transition.value.storage_class
        }
      }

    }
  }
}
