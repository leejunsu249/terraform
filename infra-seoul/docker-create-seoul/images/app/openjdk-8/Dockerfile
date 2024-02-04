FROM openjdk:8-jdk-alpine

ENV TUNA_HOME /usr/local/tuna
RUN mkdir -p $TUNA_HOME

COPY tuna-scouter-common-2.7.0.jar tuna.agent.jar tuna.conf $TUNA_HOME/
