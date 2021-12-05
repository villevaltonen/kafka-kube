set-docker-env:
	eval $(minikube docker-env)

build-zookeeper:
	docker build -f zookeeper/docker/Dockerfile -t localhost/zookeeper:latest zookeeper/docker/

build-kafka:
	docker build -f kafka/docker/Dockerfile -t localhost/kafka:latest kafka/docker/