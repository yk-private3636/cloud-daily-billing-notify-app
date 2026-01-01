module "dynamodb_next_processing_dates_table" {
  source = "../../modules/dynamodb_table"

  table_name   = local.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "cost_source"
  attributes = [
    {
      name = "cost_source"
      type = "S"
    },
  ]
}