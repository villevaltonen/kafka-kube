# Variables
ZOOKEEPER_HOME=/home/user/zookeeper
ZOOKEEPER_CONFIG=$ZOOKEEPER_HOME/conf/zoo.cfg

# Set id
ZOOKEEPER_SERVER_ID=$((${HOSTNAME##*-}+1))
echo $ZOOKEEPER_SERVER_ID >> /home/user/data/myid

# Set configs
echo clientPort=$ZOOKEEPER_CLIENT_PORT >> $ZOOKEEPER_CONFIG
echo dataDir=$ZOOKEEPER_DATA_DIR >> $ZOOKEEPER_CONFIG
echo logDataDir=$ZOOKEEPER_LOG_DATA_DIR >> $ZOOKEEPER_CONFIG

# Set servers
for (( i=0; i<$ZOOKEEPER_SERVERS; i++ ))
do  
    h=${HOSTNAME%?}${i}
    echo server.$((${i}+1))=$h.$ZOOKEEPER_SUBDOMAIN.$ZOOKEEPER_NAMESPACE.svc.$ZOOKEEPER_CLUSTER_DOMAIN:$ZOOKEEPER_SERVER_PORT:$ZOOKEEPER_LEADER_ELECTION_PORT >> $ZOOKEEPER_CONFIG
done

cat $ZOOKEEPER_CONFIG

# Start
java -cp "zookeeper-$ZOOKEEPER_VERSION.jar:$ZOOKEEPER_HOME/lib/*:$ZOOKEEPER_HOME/conf" $ZOOKEEPER_OPTS org.apache.zookeeper.server.quorum.QuorumPeerMain $ZOOKEEPER_CONFIG