module "event_developer_user_policy" {
  source = "../../modules/iam_user_policy"

  name        = local.event_developer_user_policy_name
  user_name   = module.event_developer_user.name
  policy_json = module.lambda_get_last_processed_date_role_policy.policy_json
}