# Variables
ZOOKEEPER_HOME=/home/user/zookeeper

# Set id
ZOOKEEPER_SERVER_ID=$((${HOSTNAME##*-}+1))
echo $ZOOKEEPER_SERVER_ID >> /home/user/data/myid

# Set servers
for (( i=0; i<$ZOOKEEPER_SERVERS; i++ ))
do  
    h=${HOSTNAME%?}${i}
    echo server.$((${i}+1))=$h.$ZOOKEEPER_SUBDOMAIN.$ZOOKEEPER_NAMESPACE.svc.$ZOOKEEPER_CLUSTER_DOMAIN:$ZOOKEEPER_SERVER_PORT:$ZOOKEEPER_LEADER_ELECTION_PORT
    echo server.$((${i}+1))=$h.$ZOOKEEPER_SUBDOMAIN.$ZOOKEEPER_NAMESPACE.svc.$ZOOKEEPER_CLUSTER_DOMAIN:$ZOOKEEPER_SERVER_PORT:$ZOOKEEPER_LEADER_ELECTION_PORT >> $ZOOKEEPER_HOME/conf/zoo.cfg
done

cat $ZOOKEEPER_HOME/conf/zoo.cfg

# Start
java -cp "zookeeper-$ZOOKEEPER_VERSION.jar:$ZOOKEEPER_HOME/lib/*:$ZOOKEEPER_HOME/conf" org.apache.zookeeper.server.quorum.QuorumPeerMain $ZOOKEEPER_HOME/conf/zoo.cfg