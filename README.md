# spigot-server
build the spigot server container

Mount a volume at `/home/minecraft/server`

Example:
```bash
docker run -p 25565:25565 -v /tmp:/home/minecraft/server kirinrastogi/minecraft:1.14.4
```
