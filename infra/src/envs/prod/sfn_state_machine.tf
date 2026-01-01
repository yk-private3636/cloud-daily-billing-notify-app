module "sfn_state_machine" {
  source = "../../modules/sfn_state_machine"

  name     = local.sfn_state_machine_name
  type     = "STANDARD"
  role_arn = module.sfn_role.arn
  definition_json = jsonencode({
    QueryLanguage  = "JSONata"
    StartAt        = "StartBillingNotification"
    TimeoutSeconds = 900
    States = {
      StartBillingNotification = {
        Type = "Parallel"
        End  = true
        Branches = [
          {
            StartAt = "AWSGetLastProcessedDate"
            States = {
              AWSGetLastProcessedDate = {
                Type     = "Task"
                Resource = module.lambda_get_next_processing_date_func.arn
                Arguments = {
                  "cost_source" = "aws"
                }
                Retry = [
                  {
                    ErrorEquals     = ["States.ALL"]
                    IntervalSeconds = 3
                    MaxAttempts     = 3
                  }
                ]
                End = true
              }
            }
          },
          # {
          #   StartAt = "RakutenCardGetLastProcessedDate"
          #   States = {
          #     RakutenCardGetLastProcessedDate = {
          #       Type     = "Task"
          #       Resource = module.lambda_get_last_processed_date_func.arn
          #       Arguments = {
          #         "cost_source" = "rakuten_card"
          #       }
          #       Retry = [
          #         {
          #           ErrorEquals     = ["States.ALL"]
          #           IntervalSeconds = 3
          #           MaxAttempts     = 3
          #         }
          #       ]
          #       End = true
          #     }
          #   }
          # }
        ]
      }
    }
  })
}