module "event_developer_role" {
  source = "../../modules/iam_role"

  name = local.event_developer_role_name
  assume_role_policy_json = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          AWS = [
            "arn:aws:iam::${var.account_id}:user/developers/${module.event_developer_user.name}"
          ]
        }
      }
    ]
  })
}