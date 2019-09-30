FROM debian
SHELL ["/bin/bash", "-c"]
RUN apt-get update && apt-get install -y default-jre default-jdk git maven sudo vim net-tools telnet rsyslog
RUN adduser --disabled-password flink
USER flink
WORKDIR /home/flink
ADD --chown=flink:flink cluster.sh .
RUN chmod +x cluster.sh
RUN git clone https://github.com/tud-delta/flink
WORKDIR /home/flink/flink
RUN git checkout feature-failover-standby-task-strategy
RUN mvn clean install -DskipTests -Dmaven.javadoc.skip=true -Dcheckstyle.skip=true
WORKDIR /home/flink/flink/flink-dist
RUN mvn clean install
WORKDIR /home/flink
USER root
ENTRYPOINT service rsyslog start && tail -f /dev/null
EXPOSE 8081
