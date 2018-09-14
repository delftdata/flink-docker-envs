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
	chown flink:flink .ssh/known_hosts && \
	sudo -u flink ssh-keyscan -t rsa 0.0.0.0 >> .ssh/known_hosts && \
	sudo -u flink ssh-keyscan -t rsa namenode >> .ssh/known_hosts && \
	echo "" > hadoop/etc/hadoop/slaves && \
	for i in `seq $HADOOP_DATANODE_SCALE`;
	do
		echo "${COMPOSE_PROJECT_NAME}_datanode_$i" >> hadoop/etc/hadoop/slaves;
		sudo -u flink ssh-keyscan -t rsa ${COMPOSE_PROJECT_NAME}_datanode_$i >> .ssh/known_hosts
	done && \
	sudo -u flink hadoop/bin/hdfs namenode -format && \
	sudo -u flink hadoop/sbin/start-dfs.sh && \
	sudo -u flink hadoop/bin/hdfs dfs -mkdir /flink-checkpoints
fi && \
tail -f /dev/null
