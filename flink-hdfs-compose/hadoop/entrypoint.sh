#!/bin/bash

NODE_TYPE=$1
HADOOP_DATANODE_SCALE=$2

if [ -z $HADOOP_DATANODE_SCALE ];
then
	HADOOP_DATANODE_SCALE=1
fi

service ssh start && \
service rsyslog start && \
if [ "$NODE_TYPE" == "namenode" ];
then
	touch .ssh/known_hosts && \
	chown hadoop:hadoop .ssh/known_hosts && \
	sudo -u hadoop ssh-keyscan -t rsa 0.0.0.0 >> .ssh/known_hosts && \
	sudo -u hadoop ssh-keyscan -t rsa namenode >> .ssh/known_hosts && \
	echo "" > hadoop-$HADOOP_VERSION/etc/hadoop/slaves && \
	for i in `seq $HADOOP_DATANODE_SCALE`;
	do
		echo "${COMPOSE_PROJECT_NAME}_datanode_$i" >> hadoop-$HADOOP_VERSION/etc/hadoop/slaves;
		sudo -u hadoop ssh-keyscan -t rsa ${COMPOSE_PROJECT_NAME}_datanode_$i >> .ssh/known_hosts
	done && \
	sudo -u hadoop hadoop-$HADOOP_VERSION/bin/hdfs namenode -format && \
	sudo -u hadoop hadoop-$HADOOP_VERSION/sbin/start-dfs.sh && \
	sudo -u hadoop hadoop-$HADOOP_VERSION/bin/hdfs dfs -mkdir /flink-checkpoints
fi && \
tail -f /dev/null
