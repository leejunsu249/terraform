FROM node:lts-alpine3.15

RUN sed 's/https/http/g' -i /etc/apk/repositories
RUN apk update

RUN apk add libstdc++6
# RUN apk add jq
RUN apk add git

ENV GLIBC_VER=2.31-r0

RUN apk --no-cache add \
        binutils \
        curl \
    && curl -ksL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
    && curl -ksLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk \
    && curl -ksLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk \
    && apk add --no-cache \
        glibc-${GLIBC_VER}.apk \
        glibc-bin-${GLIBC_VER}.apk \
    && curl -ksL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
    && unzip awscliv2.zip \
    && aws/install \
    && rm -rf \
        awscliv2.zip \
        aws \
        /usr/local/aws-cli/v2/*/dist/aws_completer \
        /usr/local/aws-cli/v2/*/dist/awscli/data/ac.index \
        /usr/local/aws-cli/v2/*/dist/awscli/examples
#     && apk --no-cache del \
#         binutils \
#         curl \
#     && rm glibc-${GLIBC_VER}.apk \
#     && rm glibc-bin-${GLIBC_VER}.apk \
#     && rm -rf /var/cache/apk/*


RUN sed 's/http/https/g' -i /etc/apk/repositories

RUN curl -kLO https://get.helm.sh/helm-v3.7.2-linux-amd64.tar.gz
RUN tar -xf helm-v3.7.2-linux-amd64.tar.gz
RUN mv linux-amd64/helm /usr/local/bin/helm

RUN curl -kLO https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
RUN chmod 744 jq-linux64
RUN mv jq-linux64 /usr/local/bin/jq