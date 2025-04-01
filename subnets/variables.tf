variable "vpc_id" {
  description = "VPC 생성 시 사용된 VPC ID"
  type        = string
}

variable "subnets" {
  description = "Public 서브넷에 사용할 CIDR 블록 리스트"
  type        = list(string)
  default     = []
}

variable "is_public" {
  description = "public/private 구분용도"
  type        = bool
  default     = false
}

variable "azs" {
  description = "서브넷을 생성할 가용 영역(Availability Zones) 리스트"
  type        = list(string)
}

variable "name_prefix" {
  description = "서브넷 리소스 이름 접두사"
  type        = string
}

variable "tags" {
  description = "서브넷 리소스에 적용할 공통 태그"
  type        = map(string)
  default     = {}
}

# 라우팅 테이블에 필요한 변수들
variable "gateway_ids" {
  description = "VPC에 연결된 Internet Gateway ID"
  type        = string
}
