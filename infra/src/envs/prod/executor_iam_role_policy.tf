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
          "s3:Get*",
          "s3:List*",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          var.s3_tfstate_arn,
          "${var.s3_tfstate_arn}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "states:ValidateStateMachineDefinition",
          "states:CreateStateMachine",
          "states:UpdateStateMachine",
          "states:DeleteStateMachine",
          "states:DescribeStateMachine",
          "states:ListStateMachineVersions",
          "states:ListTagsForResource",
          "states:TagResource"
        ]
        Resource = [
          module.sfn_state_machine.arn,
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "scheduler:CreateSchedule",
          "scheduler:CreateScheduleGroup",
          "scheduler:UpdateSchedule",
          "scheduler:GetSchedule",
          "scheduler:GetScheduleGroup",
          "scheduler:DeleteSchedule",
          "scheduler:DeleteScheduleGroup",
          "scheduler:DescribeSchedule",
          "scheduler:ListTagsForResource",
          "scheduler:TagResource"
        ]
        Resource = [
          module.scheduler_schedule_group.arn,
          module.scheduler_schedule.arn,
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:CreateTable",
          "dynamodb:UpdateTable",
          "dynamodb:DeleteTable",
          "dynamodb:DescribeTable",
          "dynamodb:TagResource",
          "dynamodb:UntagResource",
          "dynamodb:DescribeContinuousBackups",
          "dynamodb:DescribeTimeToLive",
          "dynamodb:ListTagsOfResource"
        ]
        Resource = [
          module.dynamodb_processed_dates.arn,
        ]
      },
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