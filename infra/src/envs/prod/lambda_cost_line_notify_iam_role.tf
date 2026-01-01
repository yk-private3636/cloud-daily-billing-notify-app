module "lambda_cost_line_notify_role" {
  source = "../../modules/iam_role"

  name = local.lambda_cost_line_notify_role_name
  assume_role_policy_json = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}