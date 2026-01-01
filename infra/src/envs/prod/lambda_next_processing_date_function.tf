module "lambda_get_next_processing_date_func" {
  source = "../../modules/lambda_function"

  function_name = local.lambda_get_next_processing_date_function_name
  role_arn      = module.lambda_get_next_processing_date_role.arn
  image_uri     = "${module.ecr_repository.url}:${var.lambda_get_next_processing_date_image_tag}"
  timeout       = 180
  memory_size   = 256
  architectures = ["x86_64"]
  environments = [
    {
      key = "APP_ENV"
      val = var.env
    },
    {
      key = "TABLE_NAME"
      val = module.dynamodb_next_processing_dates_table.name
    }
  ]
}