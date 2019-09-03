#!/bin/bash

docker kill -s SIGTERM $(docker ps -q --filter="name=k8s_spigot-server")
