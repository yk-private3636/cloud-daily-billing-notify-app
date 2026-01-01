output "arn" {
    value = aws_ecr_repository.main.arn
}

output "url" {
    value = aws_ecr_repository.main.repository_url
}

output "name" {
    value = aws_ecr_repository.main.name
}
