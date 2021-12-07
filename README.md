# kafka-kube

A hobby project to run Kafka with Zookeeper on Kubernetes.

## Running on minikube
- Works (at least) with Virtualbox driver
- Use minikube docker env: `eval $(minikube docker-env)`
- Build the images with `make`

#### Apply manifests in order:
1. Common
1. Zookeeper
1. Kafka

## Configuration

### Zookeeper
Required environment variables:

`ZOOKEEPER_SERVERS`
How many replicas you have.

`ZOOKEEPER_CLIENT_PORT`
Port for client connections.

`ZOOKEEPER_SERVER_PORT`
Port for server-to-server communication.

`ZOOKEEPER_LEADER_ELECTION_PORT`
Port for leader election.

`ZOOKEEPER_DATA_DIR`
Directory for Zookeeper data to be stored. Should match with the respective persistent volume claim.

`ZOOKEEPER_LOG_DATA_DIR`
Directory for Zookeeper logs. Should match with the respective persistent volume claim.

`ZOOKEEPER_CLUSTER_DOMAIN`
Domain of the Kubernetes cluster.

`ZOOKEEPER_NAMESPACE`
The namespace the pods are deployed into.

`ZOOKEEPER_SUBDOMAIN`
Needs to match the service and subdomains in the Kubernetes manifest.

`ZOOKEEPER_OPTS`
Java options for Zookeeper. For example JMX exporting can be done with: `-Djava.rmi.server.hostname=localhost -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9010 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.rmi.port=9010 -javaagent:/jmx_agent.jar=9556:/home/user/prometheus.conf`


### Kafka
`KAFKA_PORT`
Port for Kafka brokers.

`KAFKA_LOG_DIRS`
Directory to save Kafka logs, i.e. partition data

`KAFKA_NUM_PARTITIONS`
Default number of partitions for topics.

`KAFKA_OFFSET_TOPIC_REPLICATION_FACTOR`
Kafka offset topic replication factor.

`KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR`
Kafka transaction state log replication factor.

`KAFKA_TRANSACTION_STATE_LOG_MIN_ISR`
Minimum in sync replicas for transaction state log.

`KAFKA_ZOOKEEPER_CONNECT`
Zookeeper address.

`KAFKA_MIN_IN_SYNC_REPLICAS`
Default minimum for in sync replicas for topics.

`KAFKA_DEFAULT_REPLICATION_FACTOR`
Default replication factor for topics.

`KAFKA_SUBDOMAIN`
Needs to match the service and subdomains in the Kubernetes manifest.

`KAFKA_NAMESPACE`
The namespace the pods are deployed into.

`KAFKA_CLUSTER_DOMAIN`
Domain of the Kubernetes cluster.


Optional environment variables:

`KAFKA_HEAP_OPTS` 
For example: `"-Xmx512M -Xms512M"`

`KAFKA_OPTS`
Kafka options. For example Java options for JMX exporting can be done with: `-Djava.rmi.server.hostname=localhost -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9010 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.rmi.port=9010 -javaagent:/jmx_agent.jar=9556:/home/user/prometheus.conf`


## Administration
Administrative operations can be executed within the Kafka pods, but it requires unsetting `KAFKA_OPTS` or an error will raise due bindings by Prometheus Java agent. The standard Kafka scripts can be found at `/home/user/kafka/bin`.

## Client configuration
Clients should be able to access the cluster with the following url `kafka-client.kafka.svc.cluster.local:9092`, even from other namespaces. It follows the standard pattern of `service.namespace.svc.cluster.local`.
