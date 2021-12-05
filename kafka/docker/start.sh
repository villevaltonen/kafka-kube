# Variables
KAFKA_HOME=/home/user/kafka
KAFKA_CONFIG=$KAFKA_HOME/config/server.properties

# Set id
KAFKA_BROKER_ID=$((${HOSTNAME##*-}+1))
echo broker.id=$KAFKA_BROKER_ID >> $KAFKA_CONFIG

# Listener configs
echo listeners=PLAINTEXT://$HOSTNAME:$KAFKA_PORT >> $KAFKA_CONFIG
echo advertised.listeners=PLAINTEXT://$HOSTNAME.kafka-client.kafka.svc.cluster.local:$KAFKA_PORT >> $KAFKA_CONFIG

# Log configs
echo log.dirs=$KAFKA_LOG_DIRS >> $KAFKA_CONFIG

# Replication and partition configs
echo num.partitions=$KAFKA_NUM_PARTITIONS >> $KAFKA_CONFIG
echo offsets.topic.replication.factor=$KAFKA_OFFSET_TOPIC_REPLICATION_FACTOR >> $KAFKA_CONFIG
echo min.insync.replicas=$KAFKA_MIN_IN_SYNC_REPLICAS >> $KAFKA_CONFIG
echo default.replication.factor=$KAFKA_DEFAULT_REPLICATION_FACTOR >> $KAFKA_CONFIG

# Broker state configs
echo transaction.state.log.replication.factor=$KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR >> $KAFKA_CONFIG
echo transaction.state.log.min.isr=$KAFKA_TRANSACTION_STATE_LOG_MIN_ISR >> $KAFKA_CONFIG

# Zookeeper configs
echo zookeeper.connect=$KAFKA_ZOOKEEPER_CONNECT >> $KAFKA_CONFIG

cat $KAFKA_CONFIG

bash kafka/bin/kafka-server-start.sh kafka/config/server.properties