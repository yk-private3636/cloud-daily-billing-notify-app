module "scheduler_schedule" {
  source = "../../modules/scheduler_schedule"

  name                         = local.scheduler_name
  group_name                   = module.scheduler_schedule_group.name
  schedule_expression          = "cron(0 22 * * ? *)"
  schedule_expression_timezone = "Asia/Tokyo"

  target = {
    arn      = module.sfn_state_machine.arn
    role_arn = module.scheduler_role.arn
    retry = {
      maximum_event_age_in_seconds = 3600
      maximum_retry_attempts       = 3
    }
  }
}