#----------------------------
# CloudFront 배포 생성
#----------------------------
resource "aws_cloudfront_distribution" "cloudfront_distribution" {
  # 활성화 여부 - CloudFront 배포를 즉시 활성화할지 결정
  # 필요성: 개발 중에는 비활성화하고, 테스트 완료 후 활성화할 수 있음
  enabled = var.enabled
  
  # 기본 루트 객체 - 사용자가 도메인 루트(/)에 접근할 때 제공할 파일
  # 필요성: 웹사이트에서 index.html 등의 메인 페이지를 자동으로 제공하기 위해 필수
  default_root_object = var.default_root_object
  
  # 설명 - 배포에 대한 설명으로, AWS 콘솔에서 식별하는데 도움
  # 필요성: 여러 CloudFront 배포가 있을 때 관리자가 쉽게 구분하기 위함
  comment = "CloudFront for ${var.project_name} frontend"
  
  # 가격 등급 - CloudFront의 글로벌 배포 범위와 비용을 결정
  # 필요성: 비용 최적화와 성능 간의 균형을 맞추기 위해 중요
  # PriceClass_100: 북미/유럽(저비용), PriceClass_200: +아시아/중동/아프리카, PriceClass_All: 전세계(고비용)
  price_class = var.price_class
  
  # 오리진 설정 - 콘텐츠를 가져올 원본 서버 정의
  # 필요성: CloudFront가 캐시 미스 시 콘텐츠를 요청할 원본 서버 지정은 필수
  origin {
    domain_name = var.origin_domain_name  # S3 버킷 또는 웹서버 도메인
    origin_id   = var.origin_id  # CloudFront 내부에서 오리진을 식별하는 고유 ID
    
    # 커스텀 오리진 설정 - S3 웹사이트 또는 HTTP 서버에 접근하는 방법 정의
    # 필요성: CloudFront가 오리진 서버와 통신하는 프로토콜과 포트 지정
    custom_origin_config {
      http_port              = 80  # HTTP 요청 포트
      https_port             = 443  # HTTPS 요청 포트
      origin_protocol_policy = "http-only"  # 오리진에 접근할 프로토콜 (S3 웹사이트는 HTTP만 지원)
      origin_ssl_protocols   = ["TLSv1.2"]  # 안전한 연결을 위한 SSL 프로토콜 버전
    }
  }
  
  # 기본 캐시 동작 설정 - 모든 경로에 적용되는 기본 캐싱 규칙
  # 필요성: 콘텐츠 캐싱 방식, 허용할 HTTP 메서드, 보안 설정 등 핵심 동작 정의
  default_cache_behavior {
    # 허용 메서드 - CloudFront가 처리할 HTTP 메서드 지정
    # 필요성: GET/HEAD만 허용하면 읽기 전용, 모든 메서드는 API에 필요
    allowed_methods  = var.allowed_methods
    
    # 캐시 메서드 - CloudFront가 캐싱할 HTTP 메서드
    # 필요성: GET/HEAD는 캐싱 가능, POST/PUT 등은 캐싱하지 않아야 함
    cached_methods   = var.cached_methods
    
    # 대상 오리진 ID - 이 캐시 동작이 적용될 오리진 지정
    target_origin_id = var.origin_id
    
    # 압축 설정 - 전송 속도 향상을 위한 Gzip/Brotli 압축 활성화
    # 필요성: 대역폭 절약과 페이지 로딩 속도 향상에 도움
    compress               = true
    
    # 뷰어 프로토콜 정책 - 최종 사용자의 프로토콜 처리 방식
    # 필요성: 보안을 위해 HTTPS 사용 강제 가능(redirect-to-https)
    viewer_protocol_policy = var.viewer_protocol_policy
    
    # 캐시 TTL 설정 - 콘텐츠가 캐시에 머무는 시간 제어
    # 필요성: 콘텐츠 갱신 빈도와 오리진 서버 부하 간 균형 조절
    min_ttl                = var.min_ttl      # 최소 캐시 유지 시간 (초)
    default_ttl            = var.default_ttl  # 기본 캐시 유지 시간 (초)
    max_ttl                = var.max_ttl      # 최대 캐시 유지 시간 (초)
    
    # 포워딩 설정 - 오리진으로 전달할 요청 헤더/쿠키/쿼리스트링 지정
    # 필요성: 동적 콘텐츠, 개인화된 콘텐츠, API에 중요
    forwarded_values {
      # 쿼리스트링 포워딩 - URL의 쿼리 파라미터 전달 여부
      # 필요성: 동적 콘텐츠에서 중요하며, 캐싱 효율성에 영향
      query_string = var.forward_query_string
      
      # 쿠키 포워딩 - 사용자 쿠키 전달 방식
      # 필요성: 세션 관리, 인증 등 개인화된 콘텐츠에 중요
      cookies {
        forward = var.forward_cookies  # none, all, whitelist 중 선택
      }
    }
  }
  
  # 지역 제한 설정 - 특정 국가/지역에서의 접근 제어
  # 필요성: 법적 요구사항, 컴플라이언스, 저작권 제한 등을 위해 필요
  restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction_type  # none, whitelist, blacklist
      locations        = var.geo_restriction_locations  # 국가 코드 목록
    }
  }
  
  # HTTPS 인증서 설정 - 보안 연결을 위한 설정
  # 필요성: 데이터 암호화, 보안, SEO 및 신뢰성 향상에 필수
  viewer_certificate {
    # CloudFront 기본 인증서 사용 - *.cloudfront.net 도메인 제공
    # 필요성: 커스텀 도메인 없이도 HTTPS 활성화 가능
    cloudfront_default_certificate = true
    
    # 커스텀 인증서 사용 시 아래 설정 필요
    # acm_certificate_arn: ACM에서 발급한 인증서의 ARN
    # ssl_support_method: 인증서 제공 방식 (SNI 방식이 비용 효율적)
    # minimum_protocol_version: 보안을 위한 최소 TLS 버전
  }
  
  # 태그 - 리소스 식별 및 비용 할당을 위한 태그
  # 필요성: 리소스 관리, 비용 추적, 팀/프로젝트 별 구분에 중요
  tags = merge(
    var.common_tags,
    {
      Name = "cloudfront-${var.project_name}-frontend"
    }
  )
}