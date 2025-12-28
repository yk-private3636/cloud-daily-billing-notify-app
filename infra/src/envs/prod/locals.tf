locals {
  name = "${var.env}-${var.project_name}"

  executor_role_name        = "${local.name}-executor-role"
  executor_role_policy_name = "${local.name}-executor-policy"

  sfn_state_machine_name = "${local.name}-state-machine"
  sfn_role_name          = "${local.name}-sfn-role"
}