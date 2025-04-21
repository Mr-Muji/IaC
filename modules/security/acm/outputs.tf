#----------------------------
# ACM 인증서 출력값
#----------------------------
output "certificate_arn" {
  description = "발급된 ACM 인증서의 ARN (다른 서비스에서 참조할 때 사용)"
  value       = aws_acm_certificate.certificate.arn
}

output "certificate_domain_name" {
  description = "인증서의 메인 도메인 이름"
  value       = aws_acm_certificate.certificate.domain_name
}

output "certificate_status" {
  description = "인증서의 현재 상태"
  value       = aws_acm_certificate.certificate.status
}

output "certificate_validation_emails" {
  description = "이메일 검증 시 사용되는 이메일 주소 목록 (DNS 검증 시에는 사용되지 않음)"
  value       = aws_acm_certificate.certificate.validation_emails
}

output "distinct_domain_names" {
  description = "인증서에 포함된 모든 고유 도메인 이름 목록"
  value       = aws_acm_certificate.certificate.domain_validation_options[*].domain_name
}

output "validation_domains" {
  description = "검증에 사용되는 도메인 설정 정보"
  value = {
    for dvo in aws_acm_certificate.certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
}

output "validation_complete" {
  description = "인증서 검증이 완료되었는지 여부 (true/false)"
  value       = aws_acm_certificate_validation.certificate_validation.validation_completed
}