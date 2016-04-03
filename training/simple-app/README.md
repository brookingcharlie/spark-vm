# Spark Quick Start

Based on <http://spark.apache.org/docs/1.6.0/quick-start.html>.

## Starting a local Spark cluster

To create a local Spark cluster with a single slave:

```
/opt/spark/sbin/start-master.sh -h 192.168.50.4
/opt/spark/sbin/start-slave.sh -h 192.168.50.4 -m 1G spark://192.168.50.4:7077
```

To create a local Spark cluster with two slaves:

```
/opt/spark/sbin/start-master.sh -h 192.168.50.4
/opt/spark/bin/spark-class org.apache.spark.deploy.worker.Worker -h 192.168.50.4 -m 1G spark://192.168.50.4:7077 &
/opt/spark/bin/spark-class org.apache.spark.deploy.worker.Worker -h 192.168.50.4 -m 1G spark://192.168.50.4:7077 &
```

## Packaging the application

```
sbt package
```

## Submitting to the Spark cluster

```
/opt/spark/bin/spark-submit --class SimpleApp --master spark://192.168.50.4:7077 target/scala-2.10/simple-project_2.10-1.0.jar
```
