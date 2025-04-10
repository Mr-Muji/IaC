# 모든 환경에서 공통으로 사용되는 출력값들

output "project_name" {
  description = "프로젝트 이름"
  value       = var.project_name
}

output "environment" {
  description = "현재 환경"
  value       = var.environment
}

output "aws_region" {
  description = "AWS 리전"
  value       = var.aws_region
}

output "common_tags" {
  description = "공통 태그"
  value       = var.common_tags
}

output "domain_name" {
  description = "도메인 이름"
  value       = var.domain_name
}

output "remote_state_bucket" {
  description = "원격 상태 저장소 버킷"
  value       = var.remote_state_bucket
}

output "remote_state_region" {
  description = "원격 상태 저장소 리전"
  value       = var.remote_state_region
}
