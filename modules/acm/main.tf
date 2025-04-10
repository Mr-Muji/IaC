#----------------------------
# ACM 인증서 생성 및 검증
#----------------------------

# us-east-1 리전에 프로바이더 설정 (CloudFront는 이 리전의 인증서만 사용 가능)
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

# ACM 인증서 생성
resource "aws_acm_certificate" "certificate" {
  provider = aws.us_east_1  # CloudFront용 인증서는 반드시 us-east-1에 생성

  # 도메인 설정
  domain_name               = var.domain_name
  subject_alternative_names = var.create_wildcard_certificate ? ["*.${var.domain_name}"] : var.alternative_names
  validation_method         = "DNS"  # DNS 검증 방식 사용 (자동 갱신 가능)

  # 인증서 갱신 시 새 인증서 먼저 생성
  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    var.common_tags,
    {
      Name = "acm-${var.project_name}-${replace(var.domain_name, ".", "-")}"
    }
  )
}

# DNS 검증을 위한 Route53 레코드 생성
resource "aws_route53_record" "validation_records" {
  for_each = {
    for dvo in aws_acm_certificate.certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id         = var.route53_zone_id
  name            = each.value.name
  type            = each.value.type
  records         = [each.value.record]
  ttl             = 60
  allow_overwrite = true
}

# 인증서 검증 완료 대기
resource "aws_acm_certificate_validation" "certificate_validation" {
  provider                = aws.us_east_1
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.validation_records : record.fqdn]
}