resource "aws_lambda_function" "lambda_function_obj" {
  function_name = var.function_name
  description   = var.description
  role          = var.lambda_role
  handler       = var.handler
  runtime       = var.runtime
  memory_size   = var.memory_size
  timeout       = var.timeout
  layers        = var.layers

  logging_config {
    application_log_level = var.logging_config_application_log_level
    log_format            = var.logging_config_log_format
    log_group             = var.logging_config_log_group_name
    system_log_level      = var.logging_config_system_log_level
  }

  ephemeral_storage {
    size = var.ephemeral_storage_size
  }

  tracing_config {
    mode = var.tracing_config_mode
  }

  # Use a dummy code snippet or a minimal deployment package.
  # Developers will replace this with actual code.
  filename                       = var.filename != null ? var.filename : null
  image_uri                      = var.image_uri != null ? var.image_uri : null
  package_type                   = var.package_type
  reserved_concurrent_executions = var.reserved_concurrent_executions
  kms_key_arn                    = var.kms_key_arn

  # source_code_hash = filebase64sha256(var.filename)

  vpc_config {
    security_group_ids = var.vpc_security_group_ids != null ? var.vpc_security_group_ids : null
    subnet_ids         = var.vpc_subnet_ids != null ? var.vpc_subnet_ids : null
  }

  environment {
    variables = var.env_variables
  }



  lifecycle {
    ignore_changes = [
      filename,         # Ignore changes to the deployment package
      source_code_hash, # Ignore changes to the source code hash
      handler,          # Ignore changes to the handler
      runtime,          # Ignore changes to the runtime
      image_uri,
      layers,
      environment,
      # Add any other attributes you expect to change outside Terraform
    ]
  }

  tags = var.tags
}

