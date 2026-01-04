module "executor_sa_role_member" {
  source = "../../modules/google_project_iam_member"

  project_id = var.google_project_id
  role       = module.executor_sa_role.name
  member     = "serviceAccount:${module.executor_sa.email}"
}