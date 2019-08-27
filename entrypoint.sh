#!/bin/sh

# symlink config files from the volume at /home/minecraft/config to /home/minecraft/server
ln -sf /home/minecraft/config/whitelist.json /home/minecraft/server/whitelist.json

java -Xmx4608m -Xms4608m -XX:-UseContainerSupport -jar /jars/spigot.jar nogui
