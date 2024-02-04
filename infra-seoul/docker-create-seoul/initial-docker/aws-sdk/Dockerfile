FROM amazon/aws-cli:latest

ENV TERRAFORM_VER="1.1.5"

RUN yum install wget unzip tar gzip gettext git jq python3 openssl -y

RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/terraform_${TERRAFORM_VER}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VER}_linux_amd64.zip && \
    mv terraform /bin && \
    rm -f terraform_${TERRAFORM_VER}_linux_amd64.zip

RUN curl -LO https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /bin

RUN pip3 install boto3 python-gitlab GitPython kubernetes psycopg2-binary PyMySQL requests

RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh