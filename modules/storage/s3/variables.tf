#----------------------------
# 모듈 공통 변수들
#----------------------------
variable "project_name" {
  description = "프로젝트 이름 (예: my-awesome-project)"
  type        = string
  # 예시: "my-awesome-project", "finance-app", "web-service"
}

variable "common_tags" {
  description = "모든 리소스에 적용될 공통 태그 (예: {Environment = \"dev\"})"
  type        = map(string)
  # 예시: {
  #   Environment = "dev"
  #   Owner       = "Frontend-Team"
  # }
}

#----------------------------
# S3 버킷 관련 변수들
#----------------------------
variable "bucket_name" {
  description = "S3 버킷 이름 (글로벌하게 유일해야 함) (예: my-project-frontend-assets)"
  type        = string
  # 예시: "my-company-frontend-assets", "my-project-images"
  # 버킷 이름은 글로벌하게 유일해야 하며, 소문자, 숫자, 하이픈(-), 점(.)만 사용 가능
}

# 퍼블릭 액세스 차단 설정 관련 변수들
variable "block_public_acls" {
  description = "퍼블릭 ACL 차단 여부 (예: true)"
  type        = bool
  # 예시: true (보안을 위해 권장), false (퍼블릭 액세스 필요 시)
}

variable "block_public_policy" {
  description = "퍼블릭 정책 차단 여부 (예: true)"
  type        = bool
  # 예시: true (보안을 위해 권장), false (퍼블릭 액세스 필요 시)
}

variable "ignore_public_acls" {
  description = "모든 퍼블릭 ACL 무시 여부 (예: true)"
  type        = bool
  # 예시: true (보안을 위해 권장), false (퍼블릭 액세스 필요 시)
}

variable "restrict_public_buckets" {
  description = "퍼블릭 버킷 정책 제한 여부 (예: true)"
  type        = bool
  # 예시: true (보안을 위해 권장), false (퍼블릭 액세스 필요 시)
}