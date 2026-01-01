module "sfn_role_policy" {
  source = "../../modules/iam_role_policy"

  name    = local.sfn_role_policy_name
  role_id = module.sfn_role.id
  policy_json = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "lambda:InvokeFunction"
        ]
        Resource = [
          module.lambda_get_next_processing_date_func.arn,
        ]
      }
    ]
  })
}