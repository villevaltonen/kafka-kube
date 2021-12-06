# Builder
FROM openjdk:8-jre-slim-bullseye as builder

ADD https://dlcdn.apache.org/zookeeper/zookeeper-3.7.0/apache-zookeeper-3.7.0-bin.tar.gz apache-zookeeper-3.7.0-bin.tar.gz
RUN tar -xzf apache-zookeeper-3.7.0-bin.tar.gz

# Runtime
FROM openjdk:8-jre-slim-bullseye as runtime

RUN apt-get update && apt-get install -y procps dnsutils 
RUN adduser --disabled-password -u 1000 user

COPY --from=builder --chown=user:user /apache-zookeeper-3.7.0-bin /home/user/zookeeper/
COPY --chown=user:user zoo.cfg /home/user/zookeeper/conf/zoo.cfg
COPY start.sh /home/user/start.sh

RUN mkdir -p /home/user/data
RUN mkdir -p /home/user/logs
RUN chown -R user:user /home/user/data
RUN chown -R user:user /home/user/logs

USER 1000

WORKDIR /home/user

ENTRYPOINT ["bash", "start.sh"]