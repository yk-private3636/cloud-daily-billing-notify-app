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
            StartAt = "AWSBillingNotification"
            States = {
              AWSBillingNotification = {
                Type = "Pass"
                Assign = {
                  "cost_source" = "AWS"
                }
                Next = "AWSGetNextProcessingDate"
              },
              AWSGetNextProcessingDate = {
                Type     = "Task"
                Resource = module.lambda_get_next_processing_date_func.arn
                Arguments = {
                  "cost_source" = "{% $cost_source %}"
                }
                Output = {
                  from = "{% $states.result.next_processing_date %}"
                  to   = "{% $fromMillis($millis(), '[Y0001]-[M01]-[D01]', '+0900') %}"
                }
                Retry = [
                  {
                    ErrorEquals     = ["States.ALL"]
                    IntervalSeconds = 3
                    MaxAttempts     = 3
                  }
                ]
                Next = "AWSCostCollector"
              },
              AWSCostCollector = {
                Type     = "Task"
                Resource = module.lambda_aws_cost_collector_func.arn
                Arguments = {
                  from = "{% $states.input.from %}"
                  to   = "{% $states.input.to %}"
                }
                Output = {
                  costs = "{% $states.result.costs %}"
                }
                Retry = [
                  {
                    ErrorEquals     = ["States.ALL"]
                    IntervalSeconds = 3
                    MaxAttempts     = 3
                  }
                ]
                Next = "AWSCostLineNotify"
              }
              AWSCostLineNotify = {
                Type     = "Task"
                Resource = module.lambda_cost_line_notify_func.arn
                Arguments = {
                  cost_source = "{% $cost_source %}"
                  costs       = "{% $states.input.costs %}"
                }
                End = true
              }
            }
          },
          # {
          #   StartAt = "RakutenCardGetNextProcessingDate"
          #   States = {
          #     RakutenCardGetNextProcessingDate = {
          #       Type     = "Task"
          #       Resource = module.lambda_get_next_processing_date_func.arn
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