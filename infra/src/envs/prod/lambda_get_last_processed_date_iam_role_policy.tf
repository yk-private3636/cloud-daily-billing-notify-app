module "lambda_get_last_processed_date_role_policy" {
  source = "../../modules/iam_role_policy"

  name        = local.lambda_get_last_processed_date_role_policy_name
  role_id     = module.lambda_get_last_processed_date_role.id
  policy_json = module.lambda_get_last_processed_date_policy.policy_json
}