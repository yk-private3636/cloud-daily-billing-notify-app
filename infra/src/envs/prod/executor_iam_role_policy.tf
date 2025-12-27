module "executor_role_policy" {
  source = "../../modules/iam_role_policy"

  name    = local.executor_role_policy_name
  role_id = module.executor_role.id
  policy_json = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "iam:*",
        ]
        Resource = "*"
      },
    ]
  })
}