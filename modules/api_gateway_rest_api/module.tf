resource "aws_api_gateway_rest_api" "api_gateway_rest_api_obj" {

  count = var.create_api_gateway_rest_api ? 1 : 0

  name                         = var.name
  api_key_source               = var.api_key_source
  binary_media_types           = var.binary_media_types
  body                         = var.body
  description                  = var.description
  disable_execute_api_endpoint = var.disable_execute_api_endpoint

  endpoint_configuration {
    types            = [var.endpoint_configuration_type]
    vpc_endpoint_ids = var.vpc_endpoint_ids
  }

  minimum_compression_size = var.minimum_compression_size
  fail_on_warnings         = var.fail_on_warnings
  parameters               = var.parameters
  put_rest_api_mode        = var.put_rest_api_mode
  tags                     = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_method_settings" "api_gateway_method_settings_obj" {
  count = var.create_api_gateway_rest_api && var.create_method_settings ? 1 : 0

  rest_api_id = aws_api_gateway_rest_api.api_gateway_rest_api_obj[0].id
  stage_name  = var.stage_name
  method_path = var.method_path

  settings {
    metrics_enabled    = var.metrics_enabled
    logging_level      = var.logging_level
    data_trace_enabled = var.data_trace_enabled
  }
}

resource "aws_api_gateway_deployment" "api_gateway_deployment_obj" {
  count = var.create_api_gateway_rest_api && var.create_api_gateway_stage_deployment ? 1 : 0

  rest_api_id = aws_api_gateway_rest_api.api_gateway_rest_api_obj[0].id
  description = "Deployment for API Gateway REST API"
  triggers = {
    redeployment = sha1(jsonencode(var.body))
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "this" {
  count = var.create_api_gateway_rest_api && var.create_api_gateway_stage_deployment ? 1 : 0

  rest_api_id   = aws_api_gateway_rest_api.api_gateway_rest_api_obj[0].id
  deployment_id = aws_api_gateway_deployment.api_gateway_deployment_obj[0].id
  stage_name    = var.stage_name

  cache_cluster_enabled = var.api_gw_cache
  cache_cluster_size    = var.cache_cluster_size

  dynamic "access_log_settings" {
    for_each = var.create_access_log_group ? [1] : []
    content {
      destination_arn = var.destination_arn
      format          = var.format
    }
  }
  xray_tracing_enabled  = var.xray_tracing_enabled
  client_certificate_id = var.client_certificate_id

  tags = merge(var.tags, var.stage_deployment_tags)
}


# data "aws_iam_policy_document" "this" {
#   statement {
#     effect = "Deny"

#     principals {
#       type        = "*"
#       identifiers = ["*"]
#     }

#     sid       = "Allow invoke from source vpce"
#     actions   = ["execute-api:Invoke"]
#     resources = ["${aws_api_gateway_rest_api.api_gateway_rest_api_obj[0].execution_arn}/*"]

#     condition {
#       test     = "StringNotEquals"
#       variable = "aws:sourceVpce"
#       values   = var.vpce_source_ids
#     }

#   }
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "*"
#       identifiers = ["*"]
#     }
#     sid       = "Allow invoke from all"
#     actions   = ["execute-api:Invoke"]
#     resources = ["${aws_api_gateway_rest_api.api_gateway_rest_api_obj[0].execution_arn}/*"]
#   }
# }


# resource "aws_api_gateway_rest_api_policy" "this" {
#   rest_api_id = aws_api_gateway_rest_api.api_gateway_rest_api_obj[0].id
#   policy      = data.aws_iam_policy_document.this.json
# }
