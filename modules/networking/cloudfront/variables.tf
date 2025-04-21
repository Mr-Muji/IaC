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
# CloudFront 기본 설정
#----------------------------
variable "enabled" {
  description = "CloudFront 배포 활성화 여부 (예: true)"
  type        = bool
  # 예시: true
}

variable "default_root_object" {
  description = "기본 루트 객체 (예: index.html)"
  type        = string
  # 예시: "index.html"
}

variable "price_class" {
  description = "가격 등급 (예: PriceClass_100)"
  type        = string
  # 예시: 
  # "PriceClass_100" - 북미와 유럽만 (가장 저렴)
  # "PriceClass_200" - 북미, 유럽, 아시아, 중동, 아프리카
  # "PriceClass_All" - 전 세계 모든 엣지 로케이션 (가장 비쌈)
}

#----------------------------
# 오리진 설정
#----------------------------
variable "origin_domain_name" {
  description = "오리진(S3 버킷 등)의 도메인 이름 (예: my-bucket.s3-website.ap-northeast-2.amazonaws.com)"
  type        = string
  # 예시: "my-bucket.s3-website.ap-northeast-2.amazonaws.com" (S3 웹사이트 엔드포인트)
  # 또는 "my-bucket.s3.amazonaws.com" (S3 REST API 엔드포인트)
}

variable "origin_id" {
  description = "오리진 ID (예: S3-my-frontend-bucket)"
  type        = string
  # 예시: "S3-my-frontend-bucket"
}

#----------------------------
# 캐시 동작 설정
#----------------------------
variable "allowed_methods" {
  description = "허용할 HTTP 메서드 목록 (예: [\"GET\", \"HEAD\"])"
  type        = list(string)
  # 예시: ["GET", "HEAD"] - 읽기 전용
  # 또는 ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"] - 모든 메서드
}

variable "cached_methods" {
  description = "캐시할 HTTP 메서드 목록 (예: [\"GET\", \"HEAD\"])"
  type        = list(string)
  # 예시: ["GET", "HEAD"]
}

variable "viewer_protocol_policy" {
  description = "뷰어 프로토콜 정책 (예: redirect-to-https)"
  type        = string
  # 예시: 
  # "redirect-to-https" - HTTP를 HTTPS로 리디렉션 (권장)
  # "https-only" - HTTPS만 허용
  # "allow-all" - HTTP와 HTTPS 모두 허용
}

variable "min_ttl" {
  description = "최소 TTL (Time To Live) (예: 0)"
  type        = number
  # 예시: 0 (캐시 없음), 86400 (1일)
}

variable "default_ttl" {
  description = "기본 TTL (Time To Live) (예: 3600)"
  type        = number
  # 예시: 3600 (1시간), 86400 (1일)
}

variable "max_ttl" {
  description = "최대 TTL (Time To Live) (예: 86400)"
  type        = number
  # 예시: 86400 (1일), 31536000 (1년)
}

variable "forward_query_string" {
  description = "쿼리 스트링 포워딩 여부 (예: false)"
  type        = bool
  # 예시: false (정적 콘텐츠), true (동적 콘텐츠)
}

variable "forward_cookies" {
  description = "쿠키 포워딩 설정 (예: none)"
  type        = string
  # 예시: 
  # "none" - 쿠키 전달 안함
  # "all" - 모든 쿠키 전달
  # "whitelist" - 지정된 쿠키만 전달
}

#----------------------------
# 지역 제한 설정
#----------------------------
variable "geo_restriction_type" {
  description = "지역 제한 유형 (예: none)"
  type        = string
  # 예시: 
  # "none" - 제한 없음
  # "whitelist" - 지정된 국가만 허용
  # "blacklist" - 지정된 국가 차단
}

variable "geo_restriction_locations" {
  description = "지역 제한을 적용할 국가 코드 목록 (예: [])"
  type        = list(string)
  # 예시: [] (제한 없음)
  # 또는 ["KR", "JP", "US"] (한국, 일본, 미국만 허용 - whitelist 사용 시)
}

# 아래는 커스텀 도메인 사용 시 필요한 변수들 (주석 처리됨)
# variable "acm_certificate_arn" {
#   description = "ACM 인증서 ARN (커스텀 도메인 사용 시)"
#   type        = string
#   # 예시: "arn:aws:acm:us-east-1:123456789012:certificate/abcd1234-abcd-1234-abcd-1234abcd5678"
# }