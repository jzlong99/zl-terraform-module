output "api_gateway_rest_api_output" {
  depends_on = [aws_api_gateway_rest_api.api_gateway_rest_api_obj]
  value      = aws_api_gateway_rest_api.api_gateway_rest_api_obj
}