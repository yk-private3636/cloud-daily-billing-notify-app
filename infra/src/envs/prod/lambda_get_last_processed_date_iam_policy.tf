module "lambda_get_last_processed_date_role_policy" {
  source = "../../modules/iam_policy"

  name = local.lambda_get_last_processed_date_role_name
  path = "/"
  policy_json = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
        ]
        Resource = [
          module.dynamodb_processed_dates.arn
        ]
      }
    ]
  })
}