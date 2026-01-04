module "executor_sa_role" {
  source = "../../modules/google_project_iam_custom_role"

  role_id = local.executor_role_id
  title   = "${local.name} Executor Service Account Role"
  stage   = "GA"
  permissions = [
    "iam.roles.get",
    "iam.roles.list",
    "iam.serviceAccounts.getAccessToken",
    "iam.serviceAccounts.get",
    "iam.serviceAccounts.update",
    "resourcemanager.projects.getIamPolicy",
    "resourcemanager.projects.setIamPolicy"
  ]
}