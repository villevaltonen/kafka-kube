# Variables
ZOOKEEPER_HOME=/home/user/zookeeper

# Set id
FOO=zk-0
ZOOKEEPER_SERVER_ID=$((${FOO##*-}+1)) # TODO CHANGE TO HOSTNAME
echo $ZOOKEEPER_SERVER_ID >> /home/user/data/myid

# Set servers
for (( i=0; i<=$ZOOKEEPER_SERVERS; i++ ))
do  
    h=${FOO%?}${i}
    echo server.$((${i}+1))=$h:$SERVER_PORT:$LEADER_ELECTION_PORT >> $ZOOKEEPER_HOME/conf/zoo.cfg
done


# Start
java -cp "zookeeper-$ZOOKEEPER_VERSION.jar:$ZOOKEEPER_HOME/lib/*:$ZOOKEEPER_HOME/conf" org.apache.zookeeper.server.quorum.QuorumPeerMain $ZOOKEEPER_HOME/conf/zoo.cfg