#----------------------------
# S3 버킷 생성
#----------------------------
resource "aws_s3_bucket" "s3_bucket" {
  # 버킷 이름 (전역적으로 유일해야 함)
  bucket = var.bucket_name
  
  # S3 버킷에 태그 적용
  tags = merge(
    var.common_tags,
    {
      Name = "s3-${var.project_name}-frontend"
    }
  )
}

# 버킷의 ACL 설정 (공개 접근 차단)
resource "aws_s3_bucket_public_access_block" "s3_bucket_access" {
  bucket = aws_s3_bucket.s3_bucket.id
  
  # 퍼블릭 액세스 차단 설정
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

# 버킷 소유권 설정
resource "aws_s3_bucket_ownership_controls" "s3_bucket_ownership" {
  bucket = aws_s3_bucket.s3_bucket.id
  
  rule {
    object_ownership = "BucketOwnerPreferred"  # 버킷 소유자가 객체 소유
  }
}