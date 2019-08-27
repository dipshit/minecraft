#!/bin/sh

# symlink config files from the volume at /home/minecraft/config to /home/minecraft/server
for file in /home/minecraft/config/*
do
	ln -s /home/minecraft/config/$file /home/minecraft/server/$file
done

/sbin/tini -g -- java -Xmx4608m -Xms4608m -XX:-UseContainerSupport -jar /jars/spigot.jar nogui
