
variable "release_name" {
  type        = string
  description = "Helm release 이름"
}

variable "namespace" {
  type        = string
  description = "ALB Ingress Controller가 배포될 네임스페이스"
  default     = "kube-system"
}

variable "repo_url" {
  type        = string
  description = "Helm 차트 리포지토리 URL"
  default     = ""
}

variable "chart_name" {
  type        = string
  description = "Helm 차트 이름"
}

variable "chart_version" {
  type        = string
  description = "사용할 Helm 차트 버전"
  default     = ""
}

variable "cluster_endpoint" {
  type        = string
  description = "EKS endpoint"
}

variable "cluster_name" {
  type        = string
  description = "EKS 클러스터 이름"
}

variable "cluster_ca_certificate" {
  description = "EKS 클러스터의 CA 인증서 (BASE64 인코딩된 문자열)"
  type        = string
}

variable "values" {
  type        = list(string)
  description = "values"
  default     = []
}