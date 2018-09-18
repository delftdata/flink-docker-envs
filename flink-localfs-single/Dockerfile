FROM debian
SHELL ["/bin/bash", "-c"]
RUN apt-get update && apt-get install -y default-jre default-jdk git maven sudo vim net-tools telnet rsyslog
RUN adduser --disabled-password flink
USER flink
WORKDIR /home/flink
ADD --chown=flink:flink flink-conf.yaml .
USER root
ENTRYPOINT service rsyslog start && mv flink-conf.yaml flink/build-target/conf/ && tail -f /dev/null
EXPOSE 8081
