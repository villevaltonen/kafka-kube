# Builder
FROM openjdk:8-jre-slim-bullseye as builder

RUN apt-get update && apt-get install -y wget

RUN wget https://archive.apache.org/dist/kafka/2.8.1/kafka_2.13-2.8.1.tgz
RUN tar -xzf kafka_2.13-2.8.1.tgz

RUN wget https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.16.1/jmx_prometheus_javaagent-0.16.1.jar

# Runtime
FROM openjdk:8-jre-slim-bullseye as runtime

RUN apt-get update && apt-get install -y procps dnsutils 
RUN adduser --disabled-password -u 1000 user

COPY --from=builder --chown=user:user /kafka_2.13-2.8.1 /home/user/kafka/
COPY --from=builder --chown=user:user /jmx_prometheus_javaagent-0.16.1.jar /jmx_agent.jar
COPY --chown=user:user server.properties /home/user/kafka/config/server.properties
COPY --chown=user:user prometheus.conf /home/user/prometheus.conf
COPY start.sh /home/user/start.sh

RUN mkdir -p /home/user/data
RUN mkdir -p /home/user/logs
RUN chown -R user:user /home/user/data
RUN chown -R user:user /home/user/logs

USER 1000

WORKDIR /home/user

ENTRYPOINT ["bash", "start.sh"]