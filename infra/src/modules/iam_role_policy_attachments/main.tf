resource "aws_iam_role_policy_attachment" "main" {
    count     = length(var.role_names)
    
    role       = var.role_names[count.index]
    policy_arn = var.policy_arn
}