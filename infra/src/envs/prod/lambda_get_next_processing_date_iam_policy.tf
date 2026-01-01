module "lambda_get_next_processing_date_policy" {
  source = "../../modules/iam_policy"

  name = local.lambda_get_next_processing_date_policy_name
  path = "/"
  policy_json = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:Query",
        ]
        Resource = [
          module.dynamodb_next_processing_dates_table.arn
        ]
      }
    ]
  })
}