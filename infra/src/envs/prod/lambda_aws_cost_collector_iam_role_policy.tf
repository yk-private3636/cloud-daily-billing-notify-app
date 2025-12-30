module "lambda_aws_cost_collector_role_policy" {
  source = "../../modules/iam_role_policy"

  name        = local.lambda_aws_cost_collector_policy_name
  role_id     = module.lambda_aws_cost_collector_role.id
  policy_json = module.lambda_aws_cost_collector_policy.policy_json
}