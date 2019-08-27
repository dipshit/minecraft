#!/bin/sh

# symlink config files from the volume at /home/minecraft/config to /home/minecraft/server
ln -sf /home/minecraft/config/ops.json /home/minecraft/server/ops.json
ln -sf /home/minecraft/config/whitelist.json /home/minecraft/server/whitelist.json
ln -sf /home/minecraft/config/server.properties /home/minecraft/server/server.properties
ln -sf /home/minecraft/config/spigot.yml /home/minecraft/server/spigot.yml

/sbin/tini -g -- java -Xmx4608m -Xms4608m -XX:-UseContainerSupport -jar /jars/spigot.jar nogui
