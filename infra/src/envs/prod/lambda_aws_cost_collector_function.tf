module "lambda_aws_cost_collector_func" {
  source = "../../modules/lambda_function"

  function_name = local.lambda_aws_cost_collector_function_name
  role_arn      = module.lambda_aws_cost_collector_role.arn
  image_uri     = "${module.ecr_repository.url}:${var.lambda_aws_cost_collector_image_tag}"
  timeout       = 300
  memory_size   = 256
  architectures = ["x86_64"]
  environments = [
    {
      key = "APP_ENV"
      val = var.env
    }
  ]
}