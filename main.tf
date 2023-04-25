#------------------------------------------------------
#    Computacenter send email Lambda
#------------------------------------------------------
resource "aws_lambda_function" "this" {
  function_name    = var.name
  role             = var.role_arn
  handler          = var.handler
  filename         = var.filename
  source_code_hash = var.source_code_hash
  runtime          = var.runtime
  environment {
    variables = var.environment_vars
  }
  vpc_config {
    # Every subnet should be able to reach an EFS mount target in the same Availability Zone. Cross-AZ mounts are not permitted.
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }
  tags = merge(
    var.additional_tags,
    {
      created-by = "iac-tf"
    },
  )
}

resource "aws_lambda_event_source_mapping" "this" {
  count                  = var.event_source_arn == null ? 0 : 1
  event_source_arn       = var.event_source_arn
  function_name          = aws_lambda_function.this.arn
  starting_position      = "LATEST"
  batch_size             = 1
  enabled                = true
  maximum_retry_attempts = 1
}
