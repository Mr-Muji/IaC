# 프로젝트 기본 설정
variable "project_name" {
  description = "프로젝트 이름"
  type        = string
}

variable "environment" {
  description = "환경 (dev, staging, prod)"
  type        = string
}

variable "aws_region" {
  description = "AWS 리전"
  type        = string
}

# 도메인 설정
variable "domain_name" {
  description = "도메인 이름"
  type        = string
}

# 원격 상태 저장소 설정
variable "remote_state_bucket" {
  description = "Terraform 상태 파일을 저장하는 S3 버킷 이름"
  type        = string
}

variable "remote_state_region" {
  description = "원격 상태 저장소가 위치한 AWS 리전"
  type        = string
}

# 공통 태그
variable "common_tags" {
  description = "모든 리소스에 적용될 공통 태그"
  type        = map(string)
} 