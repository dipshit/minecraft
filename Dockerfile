FROM openjdk:12-alpine as builder
RUN apk update && \
    apk upgrade && \
    apk --no-cache add tini curl ca-certificates bind-tools openssl openssl-dev git && \
    rm -rf /var/cache/apk/*
WORKDIR /home/builder
ARG SPIGOT_REV=1.14.4
COPY build.sh .
RUN ./build.sh ${SPIGOT_REV}

FROM openjdk:14-jdk-alpine as server
ARG SPIGOT_REV=1.14.4
RUN apk update && \
    apk upgrade && \
    apk --no-cache add tini curl ca-certificates bind-tools openssl openssl-dev && \
    rm -rf /var/cache/apk/*

VOLUME /home/minecraft/server
WORKDIR /tmp/include

COPY --from=builder /home/builder/spigot-${SPIGOT_REV}.jar ./spigot.jar
COPY entrypoint.sh ./entrypoint.sh
RUN chmod +x spigot.jar
WORKDIR /home/minecraft/server

CMD ["/tmp/include/entrypoint.sh"]
