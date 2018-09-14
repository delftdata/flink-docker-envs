FROM debian
ARG FLINK_VERSION
SHELL ["/bin/bash", "-c"]
RUN apt-get update && apt-get install -y default-jre default-jdk git maven sudo vim net-tools telnet rsyslog
RUN adduser --disabled-password flink
USER flink
WORKDIR /home/flink
RUN git clone https://github.com/tud-delta/flink
WORKDIR /home/flink/flink
RUN git checkout release-$FLINK_VERSION
RUN mvn clean install -DskipTests -Dmaven.javadoc.skip=true -Dcheckstyle.skip=true
WORKDIR /home/flink/flink/flink-dist
RUN mvn clean install
WORKDIR /home/flink/flink/build-target
ADD --chown=flink:flink flink-conf.yaml conf/
ADD --chown=flink:flink entrypoint.sh /home/flink
USER root
