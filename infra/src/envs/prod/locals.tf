locals {
  name = "${var.env}-${var.project_name}"

  executor_role_name        = "${local.name}-executor-role"
  executor_role_policy_name = "${local.name}-executor-policy"

  sfn_state_machine_name = "${local.name}-state-machine"
  sfn_role_name          = "${local.name}-sfn-role"
  sfn_role_policy_name   = "${local.name}-sfn-role-policy"

  scheduler_schedule_group_name = "${local.name}-schedule-group"
  scheduler_name                = "${local.name}-scheduler"
  scheduler_role_name           = "${local.name}-scheduler-role"
  scheduler_role_policy_name    = "${local.name}-scheduler-policy"

  event_developer_user_name = "${local.name}-event-developer"
  event_developer_role_name = "${local.name}-event-developer-role"

  dynamodb_table_name = "${local.name}-processed-dates"

  lambda_get_last_processed_date_role_name        = "${local.name}-get-last-processed-date-role"
  lambda_get_last_processed_date_policy_name      = "${local.name}-get-last-processed-date-policy"
  lambda_get_last_processed_date_role_policy_name = "${local.name}-get-last-processed-date-role-policy"
  lambda_get_last_processed_date_function_name    = "${local.name}-get-last-processed-date-func"
  lambda_aws_cost_collector_policy_name           = "${local.name}-aws-cost-collector-policy"
  lambda_aws_cost_collector_function_name         = "${local.name}-aws-cost-collector-func"
  lambda_aws_cost_collector_role_name             = "${local.name}-aws-cost-collector-role"
  lambda_aws_cost_collector_role_policy_name      = "${local.name}-aws-cost-collector-role-policy"

  ecr_repository_name = "${local.name}-repository"

  ssm_parameter_line_priv_jwk_name = "/${var.project_name}/line/priv_jwk"
}