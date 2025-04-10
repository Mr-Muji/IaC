#----------------------------
# VPC 생성
#----------------------------
resource "aws_vpc" "vpc_iac" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-vpc"
    }
  )
}

#----------------------------
# Internet Gateway 생성
#----------------------------
resource "aws_internet_gateway" "igw_iac" {
  vpc_id = aws_vpc.vpc_iac.id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-igw"
    }
  )
}

#----------------------------
# 서브넷 리소스
#----------------------------

# 퍼블릭 서브넷 생성(A zone)
resource "aws_subnet" "subnet_public_azone" {
  vpc_id = aws_vpc.vpc_iac.id
  cidr_block = var.subnet_public_azone_cidr
  map_public_ip_on_launch = false # 해당 서브넷에 생성되는 모든 ec2가 자동으로 퍼블릭 ip를 가지도록 설정하는 옵션(true 설정 시)
  availability_zone = "${var.region}a"

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-subnet-public-azone"
      Tier = "Public"
    }
  )
}

# 퍼블릭 서브넷 생성(C zone)
resource "aws_subnet" "subnet_public_czone" {
  vpc_id = aws_vpc.vpc_iac.id
  cidr_block = var.subnet_public_czone_cidr
  map_public_ip_on_launch = false
  availability_zone = "${var.region}c"

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-subnet-public-czone"
      Tier = "Public"
    }
  )
}

# 프라이빗 서브넷 생성(A zone) - 애플리케이션 영역
resource "aws_subnet" "subnet_private_azone" {
  vpc_id = aws_vpc.vpc_iac.id
  cidr_block = var.subnet_private_azone_cidr
  map_public_ip_on_launch = false
  availability_zone = "${var.region}a"

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-subnet-private-azone"
      Tier = "Private-Application"
    }
  )
}

# 프라이빗 서브넷 생성(C zone) - 애플리케이션 영역
resource "aws_subnet" "subnet_private_czone" {
  vpc_id = aws_vpc.vpc_iac.id
  cidr_block = var.subnet_private_czone_cidr
  map_public_ip_on_launch = false
  availability_zone = "${var.region}c"

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-subnet-private-czone"
      Tier = "Private-Application"
    }
  )
}