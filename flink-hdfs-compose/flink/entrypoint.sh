#!/bin/bash

FLINK_NODE_TYPE=$1

service rsyslog start && \
if [ "$FLINK_NODE_TYPE" == "jobmanager" ];
then
	sudo -u flink bin/jobmanager.sh start-foreground cluster
else
	sudo -u flink bin/taskmanager.sh start-foreground
fi
