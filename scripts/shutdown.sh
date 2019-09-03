#!/bin/bash

docker stop $(docker ps -q --filter="name=k8s_spigot-server")
