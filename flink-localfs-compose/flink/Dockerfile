FROM debian
ARG FLINK_VERSION
SHELL ["/bin/bash", "-c"]
RUN apt-get update && apt-get install -y default-jre default-jdk git maven sudo vim net-tools telnet rsyslog
RUN adduser --disabled-password hadoop
USER hadoop
WORKDIR /home/hadoop
RUN git clone https://github.com/tud-delta/flink
WORKDIR /home/hadoop/flink
RUN git checkout release-$FLINK_VERSION
RUN mvn clean install -DskipTests -Dmaven.javadoc.skip=true -Dcheckstyle.skip=true
WORKDIR /home/hadoop/flink/flink-dist
RUN mvn clean install
WORKDIR /home/hadoop/flink/build-target
ADD --chown=hadoop:hadoop flink-conf.yaml conf/
WORKDIR /home/hadoop
RUN mkdir flink-checkpoints
WORKDIR /home/hadoop/flink/build-target
USER root
