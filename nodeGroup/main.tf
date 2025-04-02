provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}

resource "helm_release" "alb_ingress_controller" {
  name       = var.release_name
  namespace  = var.namespace
  repository = var.repo_url
  chart      = var.chart_name
  version    = var.chart_version

  # 필수: 클러스터 이름을 지정
  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  # AWS Load Balancer Controller가 사용할 리전 (필요시)
  set {
    name  = "region"
    value = var.region
  }

  # 서비스 어카운트 생성 여부 (기본적으로 true)
  set {
    name  = "serviceAccount.create"
    value = var.service_account_create
  }
  set {
    name  = "serviceAccount.name"
    value = var.service_account_name
  }

  # 필요에 따라 추가 설정 (예: VPC ID, 태그 등)
  # 예시로, 프라이빗 노드 그룹 배치용 label을 추가할 수 있습니다.
  set {
    name  = "nodeSelector.subnet_type"
    value = var.node_selector_value
  }

  # 추가 옵션: values 파일을 사용한다면 아래와 같이 주석 처리
  # values = [ file(var.values_file) ]
}
