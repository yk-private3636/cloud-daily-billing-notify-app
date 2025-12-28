module "event_developer_user" {
  source = "../../modules/iam_user"

  user_name = local.event_developer_user_name
  path      = "/developers/"
}