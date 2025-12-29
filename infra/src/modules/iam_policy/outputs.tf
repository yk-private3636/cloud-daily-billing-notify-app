output "arn" {
    value = aws_iam_policy.main.arn
}

output "policy_json" {
    value = aws_iam_policy.main.policy
}