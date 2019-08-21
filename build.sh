#! /bin/sh

if [ ! -f BuildTools.jar ]; then
	curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
fi

java -Xmx1024M -jar BuildTools.jar --rev "$@"
