
module "lambda_cost_line_notify_policy" {
  source = "../../modules/iam_policy"

  name = local.lambda_cost_line_notify_policy_name
  path = "/"
  policy_json = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
        ]
        Resource = [
          aws_ssm_parameter.line_priv_jwk.arn,
          aws_ssm_parameter.line_user_id.arn,
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
        ]
        Resource = [
          module.dynamodb_next_processing_dates_table.arn,
        ]
      }
    ]
  })
}