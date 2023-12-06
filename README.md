# mc-tekxit-docker - Tekxit 3.14 modpack in Docker

***You need to have Docker and Docker Compose installed***

Modify docker-compose.yml variables to suit your needs

* VER=*1.0.961* - specifies version of tekxit server (found on [https://tekxit.lol/](https://tekxit.lol/))
* MEM=4G - specifies how much RAM is allocated to the server (eg.4G) 

```
---
version: '3'
services:
  tekxit:
    image: ghcr.io/hafometh88/mc-tekxit-docker:latest
    environment:
      - VERSION:"1.0.961"
      - MEM:"4G"
    ports:
      - 25565:25565
    volumes:
      - "minecraft_data:/minecraft/tekxit"
    restart: unless-stopped

volumes:
  minecraft_data:
```
