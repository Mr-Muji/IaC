#----------------------------
# VPC 출력값
#----------------------------
output "vpc_id" {
  description = "생성된 VPC의 ID"
  value       = aws_vpc.vpc_iac.id
}

#----------------------------
# 서브넷 출력값
#----------------------------
output "public_subnet_azone_id" {
  description = "A 가용영역의 퍼블릭 서브넷 ID"
  value       = aws_subnet.subnet_public_azone.id
}

output "public_subnet_czone_id" {
  description = "C 가용영역의 퍼블릭 서브넷 ID"
  value       = aws_subnet.subnet_public_czone.id
}

output "private_subnet_azone_id" {
  description = "A 가용영역의 프라이빗 서브넷 ID"
  value       = aws_subnet.subnet_private_azone.id
}

output "private_subnet_czone_id" {
  description = "C 가용영역의 프라이빗 서브넷 ID"
  value       = aws_subnet.subnet_private_czone.id
}
