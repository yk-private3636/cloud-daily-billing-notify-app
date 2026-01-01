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
          "states:UpdateStateMachine",
          "states:DeleteStateMachine",
          "states:DescribeStateMachine",
          "states:ListStateMachineVersions",
          "states:ListTagsForResource",
          "states:TagResource",
          "states:UntagResource",
        ]
        Resource = [
          module.sfn_state_machine.arn,
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "states:ValidateStateMachineDefinition",
          "states:CreateStateMachine",
        ]
        Resource = "*"
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
          module.dynamodb_next_processing_dates_table.arn,
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "ecr:CreateRepository",
          "ecr:ListTagsForResource",
        ]
        Resource = [
          "*",
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "ecr:GetRepositoryPolicy",
          "ecr:PutImageTagMutability",
          "ecr:DeleteRepository",
          "ecr:UntagResource",
          "ecr:DeleteRepositoryPolicy",
          "ecr:SetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:TagResource",
        ]
        Resource = [
          module.ecr_repository.arn,
          "${module.ecr_repository.arn}/*",
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "lambda:CreateFunction",
          "lambda:ListTags",
          "lambda:ListVersionsByFunction"
        ]
        Resource = [
          "*",
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "lambda:GetFunction",
          "lambda:TagResource",
          "lambda:UntagResource",
          "lambda:UpdateFunctionCode",
          "lambda:UpdateFunctionConfiguration",
          "lambda:DeleteFunction",
        ]
        Resource = [
          module.lambda_aws_cost_collector_func.arn,
          module.lambda_cost_line_notify_func.arn,
          module.lambda_get_next_processing_date_func.arn
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "ssm:PutParameter",
          "ssm:GetParameter",
          "ssm:GetParameterHistory",
          "ssm:DeleteParameter",
          "ssm:AddTagsToResource",
          "ssm:RemoveTagsFromResource",
          "ssm:ListTagsForResource"
        ]
        Resource = [
          "arn:aws:ssm:${var.aws_region[0]}:${var.account_id}:parameter/cloud-daily-billing-notify-app/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "ssm:GetParameters",
          "ssm:DescribeParameters",
        ]
        Resource = "*"
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