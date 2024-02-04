FROM openjdk:11-jdk-slim

ENV LENA_HOME /usr/local/lena
ENV TUNA_HOME /usr/local/tuna
RUN mkdir -p $LENA_HOME
RUN mkdir -p $TUNA_HOME

COPY lena-advertiser-1.3.1c.jar advertiser.conf $LENA_HOME/
COPY tuna-scouter-common-2.7.0.jar tuna.agent.jar tuna.conf $TUNA_HOME/
