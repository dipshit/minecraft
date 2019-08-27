# spigot-server

My Minecraft server on GKE with preemptible nodes.

# Contributing

You don't. If you want to add yourself to the whitelist, fork the repo, and make a PR to add your name and offline UUID.
The whitelist configmap is in `k8s/dynamic/whitelist.yml`. You can find your offline UUID using [this tool](http://tools.glowingmines.eu) to generate it from your desired username.

# Use locally

Mount a map as a volume at `/home/minecraft/server`
Optionally mount a whitelist at `/home/minecraft/config/whitelist.json`

Example:

```bash
docker run -p 25565:25565 -v /tmp:/home/minecraft/server kirinrastogi/spigot-server:1.14.4
```
