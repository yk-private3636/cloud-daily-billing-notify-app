
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
          "arn:aws:ssm:${var.aws_region[0]}:${var.account_id}:parameter${local.ssm_parameter_line_priv_jwk_name}",
          "arn:aws:ssm:${var.aws_region[0]}:${var.account_id}:parameter${local.ssm_parameter_line_user_id_name}",
        ]
      }
    ]
  })
}