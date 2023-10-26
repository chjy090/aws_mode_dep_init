resource "aws_ecr_repository" "ecr_{{apply_name}}" {
  name                 = "ecr_{{apply_name}}"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "KMS"
  }
}
#resource "aws_codecommit_repository" "code_commit_{{apply_name}}" {
#  repository_name = "code_commit_{{apply_name}}"
#  description     = "This is the ECR Repository"
#}
