# docker-cloudflared-proxy-dns

[![Build and Publish](https://github.com/richardbristow/docker-cloudflared-proxy-dns/actions/workflows/build-and-publish.yml/badge.svg)](https://github.com/richardbristow/docker-cloudflared-proxy-dns/actions/workflows/build-and-publish.yml)

Runs the cloudflared service in a container, and starts a DNS over HTTPS proxy to 1.1.1.1

More information on cloudflared is available at the [Cloudflare developer site](https://developers.cloudflare.com/1.1.1.1/dns-over-https/cloudflared-proxy/).

The docker image is also available to be pulled from the GitHub container registry.

## Example usage

```docker
docker run --rm \
  -p 5053:5053/tcp \
  -p 5053:5053/udp \
  richardbristow/docker-cloudflared-proxy-dns
```

## Docker-compose example

```docker
version: '3'
services:
  docker-cloudflared-proxy-dns:
    container_name: docker-cloudflared-proxy-dns
    image: richardbristow/docker-cloudflared-proxy-dns
    restart: always
    ports:
      - 5053:5053/tcp
      - 5053:5053/udp
  ```
