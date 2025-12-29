resource "aws_dynamodb_table" "main" {
    name = var.table_name
    billing_mode = var.billing_mode
    hash_key = var.hash_key
    range_key = var.range_key

    read_capacity  = var.billing_mode == "PROVISIONED" ? var.read_capacity : null
    write_capacity = var.billing_mode == "PROVISIONED" ? var.write_capacity : null

    point_in_time_recovery {
      enabled = var.point_in_time_recovery.enabled
      recovery_period_in_days = var.point_in_time_recovery.recovery_period_in_days
    }

    dynamic "attribute" {
      for_each = var.attributes
      content {
        name = attribute.value.name
        type = attribute.value.type
      }
    }
}