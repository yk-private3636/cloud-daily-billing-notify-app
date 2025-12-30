resource "aws_lambda_function" "main" {
    function_name = var.function_name
    role          = var.role_arn
    package_type = "Image"
    image_uri     = var.image_uri
    memory_size = var.memory_size
    architectures = var.architectures
    timeout     = var.timeout

    environment {
      variables = {
        for environment in var.environments : environment.key => environment.val
      }
    }
}