FROM debian
ARG HADOOP_VERSION
SHELL ["/bin/bash", "-c"]
RUN apt-get update && apt-get install -y default-jre default-jdk ssh rsync wget sudo vim net-tools telnet rsyslog
RUN cp /usr/share/doc/rsync/examples/rsyncd.conf /etc/
RUN sed -i.bak 's/RSYNC_ENABLE=false/RSYNC_ENABLE=true/' /etc/default/rsync
RUN adduser --disabled-password flink
USER flink
WORKDIR /home/flink
RUN echo "" | ssh-keygen -t rsa -b 4096
RUN cat .ssh/id_rsa.pub >> .ssh/authorized_keys
RUN wget http://ftp.cc.uoc.gr/mirrors/apache/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
RUN tar xzf hadoop-$HADOOP_VERSION.tar.gz
RUN mv hadoop-$HADOOP_VERSION hadoop
RUN echo "PATH=\"\$HADOOP_HOME/bin:\$HADOOP_HOME/sbin:$PATH\"" >> .bashrc
ADD --chown=flink:flink hadoop-env.sh hadoop/etc/hadoop/
ADD --chown=flink:flink core-site.xml hadoop/etc/hadoop/
ADD --chown=flink:flink hdfs-site.xml hadoop/etc/hadoop/
RUN hadoop/bin/hdfs namenode -format
USER root
ENTRYPOINT service ssh start && service rsync start && \
           service rsyslog start && \
           sudo -u flink ssh-keyscan -t rsa localhost >> .ssh/known_hosts && \
           sudo -u flink ssh-keyscan -t rsa 0.0.0.0 >> .ssh/known_hosts && \
           sudo -u flink hadoop/sbin/start-dfs.sh && \
           sudo -u flink hadoop/bin/hdfs dfs -mkdir /flink-checkpoints && \
           tail -f /dev/null

EXPOSE 50070 9000
