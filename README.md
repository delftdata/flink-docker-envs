# flink-docker-envs

A collection of Docker-based Flink setups.

## About the Flink image

It contains Flink built from source (release-1.6) with enabled fault tolerance (RocksDb backend) connected to HDFS.

## Setups

- Single container: Flink and HDFS run in the same container

- Compose cluster: Flink and HDFS run as micro-services in different containers, that is Flink's job manager, Flink's task manager, HDFS's namenode, and HDFS's datanode(s) all run in different containers.

## Scaling

With the compose cluster you can scale the HDFS datanode instances and Flink taskmanagers.

- Flink taskmanagers

`docker-compose up --scale taskmanager=N`

- HDFS datanodes

`HADOOP_DATANODE_SCALE=N docker-compose up --scale datanode=N`

The reason this can not happen automatically is that the namenode has to be notified about the new slaves and connect with them via ssh so that they are added to the cluster. Check out entrypoint.sh about what precisely is required.

- To scale both you have to combine the above commands.

`HADOOP_DATANODE_SCALE=N docker-compose up --scale datanode=N taskmanager=M`
