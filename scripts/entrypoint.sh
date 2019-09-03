#!/bin/sh

# exit if ram params not set
set -u


# symlink config files from the volume at /home/minecraft/config to /home/minecraft/server
ln -sf /home/minecraft/config/whitelist.json /home/minecraft/server/whitelist.json

java -Xmx${HEAPSIZE} -Xms${HEAPSIZE} -XX:-UseContainerSupport -jar /jars/spigot.jar nogui
