module "lambda_cost_line_notify_role_policy" {
  source = "../../modules/iam_role_policy"

  name        = local.lambda_cost_line_notify_role_policy_name
  role_id     = module.lambda_cost_line_notify_role.id
  policy_json = module.lambda_cost_line_notify_policy.policy_json
}