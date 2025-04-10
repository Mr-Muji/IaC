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
# ACM 인증서 관련 변수들
#----------------------------
variable "domain_name" {
  description = "인증서를 발급할 도메인 이름 (예: example.com)"
  type        = string
  # 예시: "example.com", "myapp.io", "katebu.click"
}

variable "alternative_names" {
  description = "인증서에 추가할 대체 도메인 이름 (예: [\"www.example.com\"])"
  type        = list(string)
  default     = []
  # 예시: ["www.example.com", "api.example.com", "admin.example.com"]
  # 와일드카드 인증서를 생성하는 경우(create_wildcard_certificate=true) 이 값은 무시됨
}

variable "create_wildcard_certificate" {
  description = "와일드카드 인증서를 생성할지 여부 (*.example.com)"
  type        = bool
  # 예시: true (모든 서브도메인 포함), false (지정한 도메인만 포함)
}

variable "route53_zone_id" {
  description = "도메인의 Route53 호스팅 영역 ID"
  type        = string
  # 예시: "Z1234567890ABCDEFGHI"
  # Route53 콘솔에서 호스팅 영역 ID를 확인하거나 aws_route53_zone 데이터 소스에서 가져올 수 있음
}