module "sfn_role" {
  source = "../../modules/iam_role"

  name = local.sfn_role_name
  assume_role_policy_json = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "states.${var.aws_region[0]}.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}