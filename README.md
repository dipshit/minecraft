# Minecraft Server

My Minecraft server on GKE with preemptible nodes.

# Contributing

If you want to add yourself to the whitelist:

* Fork the repo
* Edit `k8s/whitelist.yml` to add your desired username, and its offline UUID. THIS IS CASE SENSITIVE
* You can find your offline UUID using [this api](http://tools.glowingmines.eu). Cmd example: where `YOUR_USERNAME` is your name
  * `curl -s http://tools.glowingmines.eu/convertor/nick/YOUR_USERNAME | jq '.offlinesplitteduuid'`
* Make a PR and tag me for review

# Use locally

Mount a map as a volume at `/home/minecraft/server`

Optionally mount a whitelist at `/home/minecraft/config/whitelist.json`
Set the heapsize with the `HEAPSIZE` env var

Example:

```bash
docker run -p 25565:25565 -e HEAPSIZE=3G -v /tmp:/home/minecraft/server kirinrastogi/minecraft:1.14.4
```
