resource "aws_iam_policy" "main" {
    name        = var.name
    path = var.path
    description = var.description
    policy      = var.policy_json
}