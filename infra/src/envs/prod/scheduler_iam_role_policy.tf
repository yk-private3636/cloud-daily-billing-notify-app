module "scheduler_role_policy" {
  source = "../../modules/iam_role_policy"

  name    = local.scheduler_role_policy_name
  role_id = module.scheduler_role.id
  policy_json = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "states:StartExecution",
        ]
        Resource = [
          module.sfn_state_machine.arn,
        ]
      }
    ]
  })
}