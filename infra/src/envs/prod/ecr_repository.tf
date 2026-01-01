module "ecr_repository" {
  source = "../../modules/ecr_repository"

  repository_name      = local.ecr_repository_name
  image_tag_mutability = "IMMUTABLE"
  encryption_type      = "AES256"
  scan_on_push         = true
}