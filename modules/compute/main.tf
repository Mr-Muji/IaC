
# 나중에 쿠베 클러스터 만들때 퍼블릭 서브넷에 태그 추가해주기. 저걸 해야 로드밸런서(elb)가 어디에 들어가는지 확정 가능.
resource "aws_ec2_tag" "public_subnet_elb_tag" {
  resource_id = var.public_subnet_id  # VPC 모듈에서 받은 서브넷 ID
  key         = "kubernetes.io/role/elb"
  value       = "1"
}

resource "aws_ec2_tag" "private_subnet_internal_elb_tag" {
  resource_id = var.private_subnet_id  # VPC 모듈에서 받은 서브넷 ID
  key         = "kubernetes.io/role/internal-elb"
  value       = "1"
}