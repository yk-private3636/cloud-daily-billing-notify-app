module "sfn_state_machine" {
  source = "../../modules/sfn_state_machine"

  name     = local.sfn_state_machine_name
  type     = "STANDARD"
  role_arn = module.sfn_role.arn
  definition_json = jsonencode({
    QueryLanguage  = "JSONata"
    StartAt        = "HelloWorld"
    TimeoutSeconds = 900
    States = {
      HelloWorld = {
        Type = "Pass"
        End  = true
      }
    }
  })
}