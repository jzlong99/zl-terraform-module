variable "create_api_gateway_rest_api" {
  type        = bool
  description = "Whether to create the API Gateway REST API."
  default     = false
}

variable "name" {
  type        = string
  description = "(Required) Name of the REST API. If importing an OpenAPI specification via the body argument, this corresponds to the info.title field. If the argument value is different than the OpenAPI value, the argument value will override the OpenAPI value."
}

variable "api_key_source" {
  type        = string
  description = "(Optional) Source of the API key for requests. Valid values are HEADER (default) and AUTHORIZER. If importing an OpenAPI specification via the body argument, this corresponds to the x-amazon-apigateway-api-key-source extension. If the argument value is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value."
  default     = "HEADER"
}

variable "binary_media_types" {
  type        = list(string)
  description = "(Optional) List of binary media types supported by the REST API. By default, the REST API supports only UTF-8-encoded text payloads. If importing an OpenAPI specification via the body argument, this corresponds to the x-amazon-apigateway-binary-media-types extension. If the argument value is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value."
  default     = null
}

variable "body" {
  type        = string
  description = "(Optional) OpenAPI specification that defines the set of routes and integrations to create as part of the REST API. This configuration, and any updates to it, will replace all REST API configuration except values overridden in this resource configuration and other resource updates applied after this resource but before any aws_api_gateway_deployment creation. More information about REST API OpenAPI support can be found in the API Gateway Developer Guide. \n Note: If the body argument is provided, the OpenAPI specification will be used to configure the resources, methods and integrations for the Rest API. If this argument is provided, the following resources should not be managed as separate ones, as updates may cause manual resource updates to be overwritten: aws_api_gateway_resource, aws_api_gateway_method, aws_api_gateway_method_response, aws_api_gateway_method_settings, aws_api_gateway_integration, aws_api_gateway_integration_response, aws_api_gateway_gateway_response, aws_api_gateway_model"
  default     = null
}

variable "description" {
  type        = string
  description = "(Optional) Description of the REST API. If importing an OpenAPI specification via the body argument, this corresponds to the info.description field. If the argument value is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value."
  default     = null
}


variable "disable_execute_api_endpoint" {
  type        = bool
  description = "(Optional) Whether clients can invoke your API by using the default execute-api endpoint. By default, clients can invoke your API with the default https://{api_id}.execute-api.{region}.amazonaws.com endpoint. To require that clients use a custom domain name to invoke your API, disable the default endpoint. Defaults to false. If importing an OpenAPI specification via the body argument, this corresponds to the x-amazon-apigateway-endpoint-configuration extension disableExecuteApiEndpoint property. If the argument value is true and is different than the OpenAPI value, the argument value will override the OpenAPI value."
  default     = false
}

# variable "endpoint_configuration" {
#   type = object({
#     types            = list(string)
#     vpc_endpoint_ids = optional(list(string))
#   })
#   description = "(Optional) Configuration block defining API endpoint configuration including endpoint type. Defined below \n types - (Required) List of endpoint types. This resource currently only supports managing a single value. Valid values: EDGE, REGIONAL or PRIVATE. If unspecified, defaults to EDGE. If set to PRIVATE recommend to set put_rest_api_mode = merge to not cause the endpoints and associated Route53 records to be deleted. Refer to the documentation for more information on the difference between edge-optimized and regional APIs. \n vpc_endpoint_ids - (Optional) Set of VPC Endpoint identifiers. It is only supported for PRIVATE endpoint type. If importing an OpenAPI specification via the body argument, this corresponds to the x-amazon-apigateway-endpoint-configuration extension vpcEndpointIds property. If the argument value is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value."
#   default     = null
# }

variable "endpoint_configuration_type" {
  description = "Possible values are REGIONAL, EDGE, or PRIVATE"
  type        = string
  default     = "PRIVATE"
}

variable "vpc_endpoint_ids" {
  type        = list(string)
  description = "list of VPC endpoint ID."
  default     = null
}

variable "minimum_compression_size" {
  type        = number
  description = "(Optional) Minimum response size to compress for the REST API. String containing an integer value between -1 and 10485760 (10MB). -1 will disable an existing compression configuration, and all other values will enable compression with the configured size. New resources can simply omit this argument to disable compression, rather than setting the value to -1. If importing an OpenAPI specification via the body argument, this corresponds to the x-amazon-apigateway-minimum-compression-size extension. If the argument value is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value."
  default     = 15360
}

variable "fail_on_warnings" {
  type        = bool
  description = "(Optional) Whether warnings while API Gateway is creating or updating the resource should return an error or not. Defaults to false"
  default     = false
}

variable "parameters" {
  type        = map(string)
  description = "(Optional) Map of customizations for importing the specification in the body argument. For example, to exclude DocumentationParts from an imported API, set ignore equal to documentation. Additional documentation, including other parameters such as basepath, can be found in the API Gateway Developer Guide."
  default     = null
}

variable "put_rest_api_mode" {
  type        = string
  description = "(Optional) Mode of the PutRestApi operation when importing an OpenAPI specification via the body argument (create or update operation). Valid values are merge and overwrite. If unspecificed, defaults to overwrite (for backwards compatibility). This corresponds to the x-amazon-apigateway-put-integration-method extension. If the argument value is provided and is different than the OpenAPI value, the argument value will override the OpenAPI value."
  default     = null
}

variable "vpce_source_ids" {
  type    = list(string)
  default = []
}

variable "tags" {
  type        = map(string)
  description = "(Optional) Key-value map of resource tags. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  default     = null
}


### API Gateway Stage and Deployment ###
variable "create_api_gateway_stage_deployment" {
  type        = bool
  description = "Whether to create the API Gateway stage and deployment."
  default     = false
}

variable "stage_name" {
  type    = string
  default = "api"
}

variable "api_gw_cache" {
  description = "(Optional) Whether a cache cluster is enabled for the stage"
  type        = bool
  default     = true
}

variable "cache_cluster_size" {
  description = "(Optional) Size of the cache cluster for the stage, if enabled. Allowed values include 0.5, 1.6, 6.1, 13.5, 28.4, 58.2, 118 and 237"
  type        = number
  default     = 58.2
}

variable "destination_arn" {
  description = "The ARN of the CloudWatch Logs log group to which API Gateway sends access logging information."
  type        = string
}

variable "format" {
  description = "The formatting and values of the access log."
  type        = string
}

variable "xray_tracing_enabled" {
  description = "A boolean flag to enable/disable X-Ray tracing."
  type        = bool
  default     = true
}

variable "client_certificate_id" {
  type        = string
  description = "The ID of the client certificate used by the API Gateway stage for backend authentication."
  default     = ""
}

variable "create_access_log_group" {
  type    = bool
  default = true
}

variable "stage_deployment_tags" {
  type        = map(string)
  description = "(Optional) A map of tags to assign to the resource. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  default     = null
}


### API Gateway Method Settings ###
variable "create_method_settings" {
  type        = bool
  description = "Whether to create the API Gateway method settings."
  default     = false
}

variable "method_path" {
  description = "The path of the method settings, use '/*/*' for all paths."
  type        = string
  default     = "/*/*"
}

variable "metrics_enabled" {
  description = "Boolean flag to enable/disable detailed CloudWatch metrics."
  type        = bool
}

variable "logging_level" {
  description = "The logging level for CloudWatch logs. Valid values are OFF, ERROR, or INFO."
  type        = string
}

variable "data_trace_enabled" {
  description = "Boolean flag to enable/disable full request/response logging."
  type        = bool
}
