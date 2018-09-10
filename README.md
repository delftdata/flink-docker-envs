# flink-docker-envs
A collection of Docker-based Flink setups.

## About the Flink image

It contains Flink built from source (release-1.6) with enabled fault tolerance (RocksDb backend) connected to HDFS.

## Setups

- Single container: Flink and HDFS run in the same container

- Compose cluster: Flink and HDFS run as micro-services in differen containers, that is Flink's job manager, Flink's task manager, HDFS's namenode, and HDFS's datanode(s) all run in different containers.
