#! /bin/sh

cp /tmp/include/spigot.jar /home/minecraft/server/spigot.jar
java -Xmx6G -Xms6G -jar spigot.jar nogui
