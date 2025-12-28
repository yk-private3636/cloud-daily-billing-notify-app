module "executor_role" {
  source = "../../modules/iam_role"

  name = local.executor_role_name
  assume_role_policy_json = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          AWS = [
            "arn:aws:iam::${var.account_id}:user/${var.executor_role_principal_name}",
            "arn:aws:sts::${var.account_id}:assumed-role/${local.executor_role_name}/GitHubActions"
          ]
        }
      },
      {
        Effect = "Allow"
        Action = "sts:AssumeRoleWithWebIdentity"
        Principal = {
          Federated = module.github_actions_openid_connect_provider.arn
        }
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:${var.github_owner}/${var.github_repo}:*"
          }
        }
      }
    ]
  })
}