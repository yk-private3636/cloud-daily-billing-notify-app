module "lambda_aws_cost_collector_policy" {
  source = "../../modules/iam_policy"

  name = local.lambda_aws_cost_collector_policy_name
  path = "/"
  policy_json = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ce:Get*",
        ]
        Resource = "*"
      }
    ]
  })
}