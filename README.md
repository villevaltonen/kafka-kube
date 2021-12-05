# kafka-kube

A hobby project to run Kafka with Zookeeper on Kubernetes.

## Running on minikube
- Works (at least) with Virtualbox driver
- Use minikube docker env: `eval $(minikube docker-env)`
- Build the images with `make`
- Apply manifests in order:
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

`ZOOKEEPER_DATA_DIR=`
Directory for Zookeeper data to be stored. Should match with the respective persistent volume claim.

`ZOOKEEPER_LOG_DATA_DIR`
Directory for Zookeeper logs. Should match with the respective persistent volume claim.

`ZOOKEEPER_CLUSTER_DOMAIN`
Domain of the Kubernetes cluster.

`ZOOKEEPER_NAMESPACE`
The namespace the pods are deployed into.

`ZOOKEEPER_SUBDOMAIN`
Needs to match the service and subdomains in the Kubernetes manifest.


### TODO:
- remove utils from zk image (except procps)