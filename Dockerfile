FROM adoptopenjdk/openjdk12:alpine-slim as builder
WORKDIR /home/builder
RUN apk add git
ADD https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar BuildTools.jar
ADD VERSION VERSION
RUN java -jar BuildTools.jar --rev $(cat VERSION)
RUN mkdir -p /jars
RUN mv spigot-$(cat VERSION).jar /jars/spigot.jar

FROM adoptopenjdk/openjdk12:alpine-jre as server
RUN apk update && \
    apk upgrade && \
    apk --no-cache add tini curl ca-certificates bind-tools openssl openssl-dev && \
    rm -rf /var/cache/apk/*

COPY --from=builder /jars/spigot.jar /jars/spigot.jar
RUN chmod +x /jars/spigot.jar

WORKDIR /home/minecraft/server
COPY scripts/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/sbin/tini", "-g", "--", "/entrypoint.sh"]
