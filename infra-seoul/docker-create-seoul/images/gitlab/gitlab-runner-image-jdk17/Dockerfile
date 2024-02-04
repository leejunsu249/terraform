FROM openjdk:17-jdk-slim

RUN apt-get update && apt-get -y upgrade && apt-get install -y git curl unzip && apt-get clean && apt install maven -y && apt install jq -y
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

RUN mkdir -p /root/.m2
COPY settings.xml /root/.m2/settings.xml