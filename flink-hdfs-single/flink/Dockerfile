FROM debian
SHELL ["/bin/bash", "-c"]
RUN apt-get update && apt-get install -y default-jre default-jdk git maven sudo vim net-tools telnet rsyslog
RUN adduser --disabled-password hadoop
USER hadoop
WORKDIR /home/hadoop
RUN git clone https://github.com/tud-delta/flink
WORKDIR /home/hadoop/flink
RUN git checkout release-1.6
RUN mvn clean install -DskipTests -Dmaven.javadoc.skip=true -Dcheckstyle.skip=true
WORKDIR /home/hadoop/flink/flink-dist
RUN mvn clean install
WORKDIR /home/hadoop/flink/build-target
ADD --chown=hadoop:hadoop flink-conf.yaml conf/
USER root
ENTRYPOINT service rsyslog start && \
           sudo -u hadoop bin/start-cluster.sh && \
           sudo -u hadoop tail -f /dev/null

EXPOSE 8081
