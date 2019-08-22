#! /bin/sh

if [ ! -f BuildTools.jar ]; then
	curl -o BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
fi

java -Xmx3G -jar BuildTools.jar --rev "$@"
