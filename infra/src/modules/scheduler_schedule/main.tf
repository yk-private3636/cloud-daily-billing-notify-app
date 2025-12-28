resource "aws_scheduler_schedule" "main" {
    name = var.name
    group_name = var.group_name
    state = var.state

    flexible_time_window {
      mode = "OFF"
    }

    schedule_expression = var.schedule_expression
    schedule_expression_timezone = var.schedule_expression_timezone

    target {
      arn = var.target.arn
      role_arn = var.target.role_arn

      retry_policy {
        maximum_event_age_in_seconds = var.target.retry.maximum_event_age_in_seconds
        maximum_retry_attempts       = var.target.retry.maximum_retry_attempts
      }

    # 失敗時の処理設定(必要に応じて有効化)
    #   dead_letter_config {
    #     arn = 
    #   }
    }
}