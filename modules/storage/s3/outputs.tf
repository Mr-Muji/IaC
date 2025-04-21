#----------------------------
# S3 버킷 출력값
#----------------------------
output "bucket_id" {
  description = "생성된 S3 버킷의 ID (이름)"
  value       = aws_s3_bucket.frontend_bucket.id
}

output "bucket_arn" {
  description = "생성된 S3 버킷의 ARN"
  value       = aws_s3_bucket.frontend_bucket.arn
}

output "bucket_domain_name" {
  description = "S3 버킷의 도메인 이름"
  value       = aws_s3_bucket.frontend_bucket.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "S3 버킷의 리전별 도메인 이름"
  value       = aws_s3_bucket.frontend_bucket.bucket_regional_domain_name
}