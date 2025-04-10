#--------------------------------
# 모듈 공통 변수들
#--------------------------------
variable "project_name" {
  description = "프로젝트 이름 (예: my-awesome-project)"
  type        = string
  # 예시: "my-awesome-project", "finance-app", "web-service"
}

variable "common_tags" {
  description = "모든 리소스에 적용될 공통 태그 (예: {Environment = \"dev\", Owner = \"DevOps\"})"
  type        = map(string)
  # 예시: {
  #   Environment = "dev"
  #   Owner       = "DevOps"
  #   Project     = "my-awesome-project"
  # }
}

#--------------------------------
# VPC 생성 관련 변수들
#--------------------------------
variable "vpc_cidr" {
  description = "VPC의 CIDR 블록 (예: 10.0.0.0/16)"
  type        = string
  # 예시: "10.0.0.0/16", "172.16.0.0/16", "192.168.0.0/16"
  # 대규모 네트워크의 경우 10.0.0.0/16, 중간 규모는 172.16.0.0/16, 작은 규모는 192.168.0.0/24 등을 고려하세요
}

variable "enable_dns_hostnames" {
  description = "VPC에서 DNS 호스트명 활성화 여부 (예: true)"
  type        = bool
  # 예시: true (일반적으로 true로 설정하여 EC2 인스턴스가 DNS 호스트명을 갖도록 함)
}

variable "enable_dns_support" {
  description = "VPC에서 DNS 지원 활성화 여부 (예: true)"
  type        = bool
  # 예시: true (일반적으로 true로 설정하여 VPC 내에서 DNS 확인이 가능하도록 함)
}

#--------------------------------
# 서브넷 생성 관련 변수들
#--------------------------------
variable "subnet_public_azone_cidr" {
  description = "A 가용영역 퍼블릭 서브넷의 CIDR 블록 (예: 10.0.1.0/24)"
  type        = string
  # 예시: "10.0.1.0/24" - 퍼블릭 서브넷은 일반적으로 범위의 앞쪽 블록을 사용
}

variable "subnet_public_czone_cidr" {
  description = "C 가용영역 퍼블릭 서브넷의 CIDR 블록 (예: 10.0.2.0/24)"
  type        = string
  # 예시: "10.0.2.0/24" - 서브넷 간에 겹치지 않는 CIDR 범위 사용
}

variable "subnet_private_azone_cidr" {
  description = "A 가용영역 프라이빗 서브넷의 CIDR 블록 (예: 10.0.11.0/24)"
  type        = string
  # 예시: "10.0.11.0/24" - 프라이빗 서브넷은 일반적으로 범위의 뒤쪽 블록을 사용
}

variable "subnet_private_czone_cidr" {
  description = "C 가용영역 프라이빗 서브넷의 CIDR 블록 (예: 10.0.12.0/24)"
  type        = string
  # 예시: "10.0.12.0/24" - 서브넷 간에 겹치지 않는 CIDR 범위 사용
}

variable "map_public_ip_on_launch" {
  description = "인스턴스 시작 시 퍼블릭 IP 자동 할당 여부 (퍼블릭 서브넷만 true, 프라이빗 서브넷은 항상 false)"
  type        = bool
  # 예시: true (퍼블릭 서브넷의 경우), false (프라이빗 서브넷의 경우)
  # 이 변수는 퍼블릭 서브넷에만 적용되며, 프라이빗 서브넷에서는 항상 false로 고정해야 함
}

variable "region" {
  description = "AWS 리전 (예: ap-northeast-2)"
  type        = string
  # 예시: "ap-northeast-2", "us-west-2", "eu-west-1"
  # 리전 코드는 AWS 공식 문서 참조: https://docs.aws.amazon.com/general/latest/gr/rande.html
}




