locals {
  name = "${var.env}-${var.project_name}"

  executor_role_name        = "${local.name}-executor-role"
  executor_role_policy_name = "${local.name}-executor-policy"
  executor_sa_account_id    = substr("${local.name}", 0, 30)
  executor_sa_accound_name  = "${local.name}-executor-sa"
  executor_role_id          = "terraform_executor_sa_role"

  sfn_state_machine_name = "${local.name}-state-machine"
  sfn_role_name          = "${local.name}-sfn-role"
  sfn_role_policy_name   = "${local.name}-sfn-role-policy"

  scheduler_schedule_group_name = "${local.name}-schedule-group"
  scheduler_name                = "${local.name}-scheduler"
  scheduler_role_name           = "${local.name}-scheduler-role"
  scheduler_role_policy_name    = "${local.name}-scheduler-policy"

  event_developer_user_name = "${local.name}-event-developer"
  event_developer_role_name = "${local.name}-event-developer-role"

  dynamodb_table_name = "${local.name}-next-processing-dates"

  lambda_get_next_processing_date_role_name        = "${local.name}-get-next-date-role"
  lambda_get_next_processing_date_policy_name      = "${local.name}-get-next-date-policy"
  lambda_get_next_processing_date_role_policy_name = "${local.name}-get-next-date-role-policy"
  lambda_get_next_processing_date_function_name    = "${local.name}-get-next-date-func"
  lambda_aws_cost_collector_policy_name            = "${local.name}-aws-cost-collector-policy"
  lambda_aws_cost_collector_function_name          = "${local.name}-aws-cost-collector-func"
  lambda_aws_cost_collector_role_name              = "${local.name}-aws-cost-collector-role"
  lambda_aws_cost_collector_role_policy_name       = "${local.name}-aws-cost-collector-role-policy"
  lambda_cost_line_notify_policy_name              = "${local.name}-cost-line-notify-policy"
  lambda_cost_line_notify_role_name                = "${local.name}-cost-line-notify-role"
  lambda_cost_line_notify_function_name            = "${local.name}-cost-line-notify-func"
  lambda_cost_line_notify_role_policy_name         = "${local.name}-cost-line-notify-role-policy"

  ecr_repository_name = "${local.name}-repository"

  ssm_parameter_line_priv_jwk_name = "/${var.project_name}/line/priv_jwk"
  ssm_parameter_line_user_id_name  = "/${var.project_name}/line/user_id"
}