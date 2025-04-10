#----------------------------
# CloudFront 출력값
#----------------------------
output "distribution_id" {
  description = "CloudFront 배포 ID"
  value       = aws_cloudfront_distribution.frontend_distribution.id
}

output "distribution_arn" {
  description = "CloudFront 배포 ARN"
  value       = aws_cloudfront_distribution.frontend_distribution.arn
}

output "domain_name" {
  description = "CloudFront 도메인 이름"
  value       = aws_cloudfront_distribution.frontend_distribution.domain_name
}

output "hosted_zone_id" {
  description = "CloudFront 호스트 영역 ID (Route53 설정 시 필요)"
  value       = aws_cloudfront_distribution.frontend_distribution.hosted_zone_id
}

output "status" {
  description = "CloudFront 배포 상태"
  value       = aws_cloudfront_distribution.frontend_distribution.status
}