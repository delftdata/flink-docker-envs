FROM debian
SHELL ["/bin/bash", "-c"]
RUN apt-get update && apt-get install -y default-jre default-jdk ssh rsync wget sudo vim net-tools telnet rsyslog
RUN cp /usr/share/doc/rsync/examples/rsyncd.conf /etc/
RUN sed -i.bak 's/RSYNC_ENABLE=false/RSYNC_ENABLE=true/' /etc/default/rsync
RUN adduser --disabled-password hadoop
USER hadoop
WORKDIR /home/hadoop
RUN echo "" | ssh-keygen -t rsa -b 4096
RUN cat .ssh/id_rsa.pub >> .ssh/authorized_keys
RUN wget http://ftp.cc.uoc.gr/mirrors/apache/hadoop/common/hadoop-2.8.4/hadoop-2.8.4.tar.gz
RUN tar xzf hadoop-2.8.4.tar.gz
RUN echo "export HADOOP_HOME=/home/hadoop/hadoop-2.8.4" >> .bashrc
RUN echo "PATH=\"\$HADOOP_HOME/bin:\$HADOOP_HOME/sbin:$PATH\"" >> .bashrc
ADD --chown=hadoop:hadoop hadoop-env.sh hadoop-2.8.4/etc/hadoop/
ADD --chown=hadoop:hadoop core-site.xml hadoop-2.8.4/etc/hadoop/
ADD --chown=hadoop:hadoop hdfs-site.xml hadoop-2.8.4/etc/hadoop/
RUN hadoop-2.8.4/bin/hdfs namenode -format
USER root
ENTRYPOINT service ssh start && service rsync start && \
           service rsyslog start && \
           sudo -u hadoop ssh-keyscan -t rsa localhost >> .ssh/known_hosts && \
           sudo -u hadoop ssh-keyscan -t rsa 0.0.0.0 >> .ssh/known_hosts && \
           sudo -u hadoop hadoop-2.8.4/sbin/start-dfs.sh && \
           sudo -u hadoop hadoop-2.8.4/bin/hdfs dfs -mkdir /flink-checkpoints && \
           tail -f /dev/null

EXPOSE 50070 9000
