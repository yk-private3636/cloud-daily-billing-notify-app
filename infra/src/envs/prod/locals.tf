locals {
  name = "${var.env}-${var.project_name}"

  executor_role_name = "${local.name}-executor-role"
}