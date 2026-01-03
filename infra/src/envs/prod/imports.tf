import {
  to = module.executor_role.aws_iam_role.main
  identity = {
    "name" = local.executor_role_name
  }
}

import {
  id = "projects/${var.project_name}/serviceAccounts/${var.google_service_account_email}"
  to = module.executor_sa.google_service_account.main
}