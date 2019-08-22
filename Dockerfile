FROM adoptopenjdk/openjdk12:alpine-slim as builder
WORKDIR /home/builder
ARG SPIGOT_REV=1.14.4
RUN apk add git
ADD https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar BuildTools.jar
RUN java -Xmx6G -jar BuildTools.jar --rev ${SPIGOT_REV}

FROM adoptopenjdk/openjdk12:alpine-jre as server
ARG SPIGOT_REV=1.14.4
RUN apk update && \
    apk upgrade && \
    apk --no-cache add tini curl ca-certificates bind-tools openssl openssl-dev && \
    rm -rf /var/cache/apk/*

COPY --from=builder /home/builder/spigot-${SPIGOT_REV}.jar /jars/spigot.jar
RUN chmod +x /jars/spigot.jar

WORKDIR /home/minecraft/server
CMD ["/sbin/tini", "-g", "--", "java", "-Xmx6G", "-Xms6G", "-jar", "/jars/spigot.jar", "nogui"]
