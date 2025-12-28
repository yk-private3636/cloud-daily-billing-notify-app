module "scheduler_role" {
  source = "../../modules/iam_role"

  name = local.scheduler_role_name
  assume_role_policy_json = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "scheduler.${var.aws_region[0]}.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}