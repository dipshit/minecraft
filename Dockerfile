FROM arm32v7/openjdk:7-jdk as builder
WORKDIR /home/builder
ARG SPIGOT_REV=1.14.4
COPY build.sh .
RUN ./build.sh ${SPIGOT_REV}

FROM arm32v7/openjdk:7-jre-alpine as server
ARG SPIGOT_REV=1.14.4
RUN apk update && \
    apk upgrade && \
    apk --no-cache add tini curl ca-certificates bind-tools openssl openssl-dev && \
    rm -rf /var/cache/apk/*

RUN addgroup -S minecraft && adduser -S minecraft -G minecraft

VOLUME /home/minecraft/server
WORKDIR /tmp/include
RUN chown -R minecraft:minecraft /home/minecraft/server

COPY --from=builder /home/builder/spigot-${SPIGOT_REV}.jar ./spigot.jar
COPY entrypoint.sh ./entrypoint.sh
RUN chmod +x spigot.jar
WORKDIR /home/minecraft/server
USER minecraft

CMD ["/tmp/include/entrypoint.sh"]
