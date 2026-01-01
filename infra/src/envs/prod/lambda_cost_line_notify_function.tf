module "lambda_cost_line_notify_func" {
  source = "../../modules/lambda_function"

  function_name = local.lambda_cost_line_notify_function_name
  role_arn      = module.lambda_cost_line_notify_role.arn
  image_uri     = "${module.ecr_repository.url}:${var.lambda_cost_line_notify_image_tag}"
  timeout       = 900
  memory_size   = 1024
  architectures = ["x86_64"]
  environments = [
    {
      key = "APP_ENV"
      val = var.env
    },
    {
      key = "TABLE_NAME"
      val = module.dynamodb_next_processing_dates_table.name
    },
    {
      key = "SSM_LINE_PRIV_JWK_NAME"
      val = aws_ssm_parameter.line_priv_jwk.name
    },
    {
      key = "SSM_LINE_USER_ID_NAME"
      val = aws_ssm_parameter.line_user_id.name
    },
    {
      key = "LINE_KID"
      val = var.line_kid
    },
    {
      key = "LINE_CHANNEL_ID"
      val = var.line_channel_id
    },
    {
      key = "LINE_AUDIENCE"
      val = "https://api.line.me/"
    },
    {
      key = "LINE_API_BASE_URI"
      val = "https://api.line.me"
    }
  ]
}