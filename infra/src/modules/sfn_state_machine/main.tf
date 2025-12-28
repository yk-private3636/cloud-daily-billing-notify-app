resource "aws_sfn_state_machine" "main" {
    name = var.name
    type = var.type
    role_arn = var.role_arn

    definition = var.definition_json
}