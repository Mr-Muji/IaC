/**
 * AWS 프로바이더 설정 파일
 * 이 파일은 Terraform과 AWS 프로바이더 버전을 지정하고 AWS 리전을 설정합니다.
 */

# AWS 프로바이더 설정
provider "aws" {
  region = var.aws_region # 배포할 AWS 리전 지정
  
  # 태그 기본값 설정 - 모든 리소스에 자동 적용
  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      Owner       = var.owner
      ManagedBy   = "Terraform"
    }
  }
}

# Terraform 설정 및 필요한 프로바이더 버전 지정
terraform {
  # Terraform 버전 제약 설정
  required_version = ">= 1.0.0, < 2.0.0"
  
  # 필요한 프로바이더 및 버전 제약 설정
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # AWS 프로바이더 버전 고정
    }
  }
  
  # 원격 상태 저장소 설정은 backend.tf로 분리하는 것을 권장합니다
}

/**
 * 변수 선언
 * 이 변수들은 variables.tf에 정의되어야 합니다
 * - aws_region: AWS 리전 (예: ap-northeast-2)
 * - project_name: 프로젝트 이름
 * - environment: 환경 (dev, staging, prod 등)
 * - owner: 리소스 소유자 또는 팀
 */
