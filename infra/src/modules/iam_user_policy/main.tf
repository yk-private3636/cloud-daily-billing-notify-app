resource "aws_iam_user_policy" "main" {
    name = var.name
    user = var.user_name
    policy = var.policy_json
}