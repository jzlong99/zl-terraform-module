variable "function_name" {
  type        = string
  description = "The name of the Lambda function."
}

variable "description" {
  type        = string
  description = "The description of the Lambda function."
}

variable "lambda_role" {
  type        = string
  description = "The ARN of the IAM role attached to the Lambda function."
}

variable "handler" {
  type        = string
  description = "The function entrypoint in your code."
}

variable "runtime" {
  type        = string
  description = "The identifier of the function's runtime."
}

variable "memory_size" {
  type        = number
  description = "The amount of memory in MB your Lambda Function can use at runtime."
}

variable "timeout" {
  type        = number
  description = "The amount of time your Lambda Function has to run in seconds."
}

variable "filename" {
  type        = string
  description = "The path to the function's deployment package within the local filesystem."
  default     = null
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "A list of security group IDs associated with the Lambda function."
  default     = []
}

variable "vpc_subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs associated with the Lambda function."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "(Optional) Key-value map of resource tags. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  default     = null
}

variable "logging_config_log_format" {
  type        = string
  description = "(Required) select between Text and structured JSON format for your function's logs"
}

variable "logging_config_log_group_name" {
  type        = string
  description = "(Optional) the CloudWatch log group your function sends logs to"
  default     = null
}

variable "ephemeral_storage_size" {
  type        = number
  description = "(Required) The size of the Lambda function Ephemeral storage(/tmp) represented in MB. The minimum supported ephemeral_storage value defaults to 512MB and the maximum supported value is 10240MB"
  default     = 512
}

variable "image_uri" {
  type        = string
  description = "(Optional) The URI of a container image in the Amazon ECR registry."
  default     = null
}

variable "package_type" {
  type        = string
  description = "The type of deployment package. Set to Image for container image and Zip for .zip file archive."
  default     = "Zip"
}

variable "tracing_config_mode" {
  type        = string
  description = "(Required) Whether to sample and trace a subset of incoming requests with AWS X-Ray. Valid values are PassThrough and Active. If PassThrough, Lambda will only trace the request from an upstream service if it contains a tracing header with \"sampled=1\". If Active, Lambda will respect any tracing header it receives from an upstream service. If no tracing header is received, Lambda will call X-Ray for a tracing decision."
  default     = "PassThrough"
}

variable "env_variables" {
  type        = map(string)
  description = "(Optional) A map that defines environment variables for the Lambda function."
  default     = null
}

variable "layers" {
  type        = list(string)
  description = "(Optional) A list of Lambda Layer Version ARNs (maximum of 5) to attach to the Lambda function."
  default     = []
}

variable "logging_config_application_log_level" {
  type        = string
  description = "(Optional) The log level the function should use. Valid options are ALL, TRACE, DEBUG, INFO, WARN, ERROR, FATAL, OFF. Defaults to INFO."
  default     = "INFO"
}

variable "logging_config_system_log_level" {
  type        = string
  description = "(Optional) The log level the function should use. Valid options are ALL, TRACE, DEBUG, INFO, WARN, ERROR, FATAL, OFF. Defaults to INFO."
  default     = "INFO"
}

variable "reserved_concurrent_executions" {
  type        = number
  description = "(Optional) Amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. Defaults to Unreserved Concurrency Limits -1."
  default     = -1
}

variable "kms_key_arn" {
  description = "(Optional) The ARN for the KMS encryption key. If this is set, the function will be encrypted using the provided KMS key."
  type        = string
  default     = null
}
