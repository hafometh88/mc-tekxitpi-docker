# mc-tekxitpi-docker

Docker container for running a Tekxit 3.14 Minecraft server. This container automatically handles server installation, updates, and configuration.

## Features

- Automatic server installation and updates
- Configurable memory allocation
- Persistent data storage
- Automatic restart on failure
- Support for latest version or specific versions
- Health monitoring
- Graceful shutdown using named pipe for stdin

## Prerequisites

- [Docker](https://docs.docker.com/engine/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Quick Start

1. Create a `docker-compose.yml`:
```yaml
---
services:
  tekxitpi:
    container_name: tekxitpi
    image: ghcr.io/hafometh88/mc-tekxitpi-docker:latest
    environment:
      - VER=latest
      - MEM=4G
    ports:
      - 25565:25565
    volumes:
      - "./minecraft:/minecraft"
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "nc", "-z", "localhost", "25565"]
      interval: 30s
      timeout: 10s
      retries: 3
```

2. Start the server:
```bash
docker compose up -d
```

## Configuration

### Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `VER` | Server version. Use `latest` for automatic updates or specific version (e.g., `1.0.980`) | `latest` |
| `MEM` | Memory allocation for the server | `4G` |

### Ports

- `25565`: Minecraft server port

### Volumes

- `./minecraft:/minecraft/tekxit`: Server data directory

## Updating

The server will automatically update if:
- `VER=latest` is set
- A new version is available on [tekxit.lol](https://tekxit.lol/)

To update to a specific version, change the `VER` environment variable.
