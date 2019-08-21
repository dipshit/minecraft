FROM openjdk:8 as builder
WORKDIR /home/builder
ARG SPIGOT_REV=1.14.4
COPY build.sh .
RUN ./build.sh ${SPIGOT_REV}

RUN chmod +x spigot-${SPIGOT_REV}.jar

FROM openjdk:8u212-jre-alpine
ARG SPIGOT_REV=1.14.4
RUN apk update && \
    apk upgrade && \
    apk --no-cache add tini curl ca-certificates bind-tools openssl openssl-dev && \
    rm -rf /var/cache/apk/*

RUN addgroup -S minecraft && adduser -S minecraft -G minecraft

WORKDIR /home/minecraft/server
RUN chown -R minecraft:minecraft /home/minecraft/server
USER minecraft

COPY --from=builder /home/builder/spigot-${SPIGOT_REV}.jar ./spigot.jar
COPY entrypoint.sh ./entrypoint.sh

CMD ["/sbin/tini", "-g", "--", "./entrypoint.sh"]
