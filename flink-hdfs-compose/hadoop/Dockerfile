FROM debian
ARG HADOOP_VERSION
SHELL ["/bin/bash", "-c"]
RUN apt-get update && apt-get install -y default-jre default-jdk ssh rsync wget sudo vim net-tools telnet rsyslog
RUN cp /usr/share/doc/rsync/examples/rsyncd.conf /etc/
RUN sed -i.bak 's/RSYNC_ENABLE=false/RSYNC_ENABLE=true/' /etc/default/rsync
RUN adduser --disabled-password hadoop
USER hadoop
WORKDIR /home/hadoop
RUN echo "" | ssh-keygen -t rsa -b 4096
RUN cat .ssh/id_rsa.pub >> .ssh/authorized_keys
RUN wget http://ftp.cc.uoc.gr/mirrors/apache/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz
RUN tar xzf hadoop-${HADOOP_VERSION}.tar.gz
RUN echo "PATH=\"\$HADOOP_HOME/bin:\$HADOOP_HOME/sbin:$PATH\"" >> .bashrc
ADD --chown=hadoop:hadoop hadoop-env.sh hadoop-${HADOOP_VERSION}/etc/hadoop/
ADD --chown=hadoop:hadoop core-site.xml hadoop-${HADOOP_VERSION}/etc/hadoop/
ADD --chown=hadoop:hadoop hdfs-site.xml hadoop-${HADOOP_VERSION}/etc/hadoop/
ADD --chown=hadoop:hadoop entrypoint.sh /home/hadoop
USER root
