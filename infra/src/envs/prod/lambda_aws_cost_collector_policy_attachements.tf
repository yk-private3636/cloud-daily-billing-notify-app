module "lambda_aws_cost_collector_policy_attachments" {
  source = "../../modules/iam_role_policy_attachments"

  role_names = [
    module.event_developer_role.name
  ]
  policy_arn = module.lambda_aws_cost_collector_policy.arn
}