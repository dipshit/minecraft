# spigot-server

My Minecraft server on GKE with preemptible nodes.

# Contributing

If you want to add yourself to the whitelist:

* Fork the repo
* Edit `k8s/dynamic/whitelist.yml` to add your desired username, and its offline UUID
* You can find your offline UUID using [this tool](http://tools.glowingmines.eu). Enter your username to get it
* Make a PR and tag me for review

# Use locally

Mount a map as a volume at `/home/minecraft/server`

Optionally mount a whitelist at `/home/minecraft/config/whitelist.json`

Example:

```bash
docker run -p 25565:25565 -v /tmp:/home/minecraft/server kirinrastogi/spigot-server:1.14.4
```
