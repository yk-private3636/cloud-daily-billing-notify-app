module "dynamodb_processed_dates" {
  source = "../../modules/dynamodb_table"

  table_name   = local.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"

  hash_key  = "cost_source"
  range_key = "processed_date"
  attributes = [
    {
      name = "cost_source"
      type = "S"
    },
    {
      name = "processed_date"
      type = "S"
    },
  ]
}