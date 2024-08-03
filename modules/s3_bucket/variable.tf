# Purpose: Define the input variables for the S3 bucket module
variable "expected_bucket_owner" {
  description = "The account ID of the expected bucket owner"
  type        = string
  default     = ""
}

# Purpose: Define the input variables for the S3 bucket resource
variable "create_bucket" {
  description = "A boolean that indicates whether the S3 bucket should be created"
  type        = bool
  default     = true
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "tags" {
  description = "Tags for the S3 bucket"
  type        = map(string)
  default     = null
}

variable "force_destroy" {
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error"
  type        = bool
  default     = false
}


# Purpose: Define the input variable for the S3 bucket object Lock configuration resource
variable "object_lock_enabled" {
  description = "A boolean that indicates whether the S3 bucket object lock configuration should be enabled"
  type        = bool
  default     = false
}

variable "rules" {
  description = "The Object Lock configuration that you want to apply to the S3 bucket"
  type = object({
    mode = string
    days = number
  })
  default = null
}


# Purpose: Define the input variable for the S3 bucket lifecycle configuration resource
variable "lifecycle_configuration_enabled" {
  description = "A boolean that indicates whether the S3 bucket lifecycle configuration should be enabled"
  type        = bool
  default     = false
}

variable "lifecycle_configuration_rules" {
  description = "The lifecycle configuration rules that you want to apply to the S3 bucket"
  type = object({
    id     = string
    status = string
    filter = optional(object({
      prefix                   = string
      object_size_greater_than = optional(number)
      object_size_less_than    = optional(number)

      and = optional(list(object({
        prefix                   = string
        object_size_greater_than = optional(number)
        object_size_less_than    = optional(number)
      })))
    }), null)

    abort_incomplete_multipart_upload = optional(object({
      days_after_initiation = number
    }), null)

    expiration = optional(object({
      days = number
    }), null)

    noncurrent_version_expiration = optional(object({
      newer_noncurrent_versions = optional(number)
      noncurrent_days           = optional(number)
    }), null)
  })
  default = null
}
