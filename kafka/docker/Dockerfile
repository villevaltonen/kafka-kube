# Builder
FROM openjdk:8-jre-slim-bullseye as builder

# TODO: remove copy
#ADD https://archive.apache.org/dist/kafka/2.8.1/kafka_2.13-2.8.1.tgz kafka_2.13-2.8.1.tgz
COPY kafka_2.13-2.8.1.tgz kafka_2.13-2.8.1.tgz
RUN tar -xzf kafka_2.13-2.8.1.tgz

# Runtime
FROM openjdk:8-jre-slim-bullseye as runtime

RUN apt-get update && apt-get install -y procps dnsutils 
RUN adduser --disabled-password -u 1000 user

COPY --from=builder --chown=user:user /kafka_2.13-2.8.1 /home/user/kafka/
COPY --chown=user:user server.properties /home/user/kafka/config/server.properties
COPY start.sh /home/user/start.sh

RUN mkdir -p /home/user/data
RUN mkdir -p /home/user/logs
RUN chown -R user:user /home/user/data
RUN chown -R user:user /home/user/logs

USER 1000

WORKDIR /home/user

ENTRYPOINT ["bash", "start.sh"]