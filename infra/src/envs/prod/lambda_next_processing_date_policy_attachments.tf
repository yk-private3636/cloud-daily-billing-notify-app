module "lambda_get_next_processing_date_policy_attachments" {
  source = "../../modules/iam_role_policy_attachments"

  role_names = [
    module.event_developer_role.name
  ]
  policy_arn = module.lambda_get_next_processing_date_policy.arn
}