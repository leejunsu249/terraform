FROM gcr.io/kaniko-project/executor:debug
FROM alpine:3.14.2

RUN apk --update add curl

COPY --from=kaniko /kaniko/ /kaniko/

ENV PATH $PATH:/usr/local/bin:/kaniko
ENV DOCKER_CONFIG /kaniko/.docker/
ENV SSL_CERT_DIR /kaniko/ssl/certs
