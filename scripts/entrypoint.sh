#!/bin/sh

# symlink config files from the volume at /home/minecraft/config to /home/minecraft/server
ln -sf /home/minecraft/config/whitelist.json /home/minecraft/server/whitelist.json

java -Xmx8G -Xms8G -XX:-UseContainerSupport -jar /jars/spigot.jar nogui
