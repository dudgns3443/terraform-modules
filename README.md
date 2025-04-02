# terraform-modules
terraform-modules

모듈 디렉토릭 구성은 다음과 같이 리소스별로 단순하게 구성되어있습니다.

vpc, eks, ecr, nodegroup 은 공식모듈을 사용했기에 모듈에서 제외되었습니다.

실질적으로 module이 작성된건 helm 모듈 뿐입니다.

```
modules
   ├── iam
   ├── route53
   ├── cloudfront
   ├── securityGroup
   ├── subnet
   ├── nodegroup
   ├── helm
        ├── charts                   # helm 로컬 차트 디렉토리
        ├── main.tf
        ├── variables.tf
        ├── ouput.tf
```
