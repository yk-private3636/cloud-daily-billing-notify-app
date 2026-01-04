resource "google_project_iam_custom_role" "main" {
    role_id     = var.role_id
    title       = var.title
    description = var.description
    permissions = var.permissions
    stage       = var.stage
}