module "ecr_repository_policy" {
  source = "../../modules/ecr_repository_policy"

  repository_name = module.ecr_repository.name
  policy_json     = data.aws_iam_policy_document.ecr_repository_policy.json
}

data "aws_iam_policy_document" "ecr_repository_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
    ]
  }
}