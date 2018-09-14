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
ADD --chown=flink:flink entrypoint.sh /home/flink
USER root
