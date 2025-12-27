module "executor_role" {
  source = "../../modules/iam_role"

  name = local.executor_role_name
  assume_role_policy_json = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = [
            "arn:aws:iam::${var.account_id}:user/${var.executor_role_principal_name}",
            "arn:aws:sts::${var.account_id}:assumed-role/${local.executor_role_name}/GitHubActions"
          ]
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}