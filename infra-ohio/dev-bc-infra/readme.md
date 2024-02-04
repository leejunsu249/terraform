## 1. INFO

로컬에서 사용할 수 있게 구성 된 것이고 사용하려면 적절한 AWS Profile이 있어야 합니다.

DEV BC, NEW 인프라를 위한 테라폼 코드 입니다. 




## 2. 생성 리소스 

Cloudfront
- Market-place(bc), Creator(bc)

ACM
- *.dev-bc.naemo.io, *.dev-new.naemo.io

Route53 
- dev-bc.naemo.io , dev-new.naemo.io

S3
- All Application bc 

ECR 
- All Application(bc)

Cognito
- market , systemadmin (ohio,seul)

Redis
- api-cahing , realtime-service, session-service (ohio,seul)

## 3. 실행 코드  

    terraform apply -var-file configure/dev.tfvars


