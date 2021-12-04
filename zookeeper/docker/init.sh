#!/bin/bash

POD_NAME=$HOSTNAME
ZOOKEEPER_SERVER_ID=$((${POD_NAME: -1} + 1))

/etc/confluent/docker/run