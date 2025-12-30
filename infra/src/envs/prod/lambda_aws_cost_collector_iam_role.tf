module "lambda_aws_cost_collector_role" {
  source = "../../modules/iam_role"

  name = local.lambda_aws_cost_collector_role_name
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