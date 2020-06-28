# docker-cloudflared-proxy-dns

Runs the cloudflared service in a container, and starts a DNS over HTTPS proxy to 1.1.1.1

More information on cloudflared is available at the [Cloudflare developer site](https://developers.cloudflare.com/1.1.1.1/dns-over-https/cloudflared-proxy/).

## Example usage

```docker
docker run --rm \
  -p 5053:5053/tcp \
  -p 5053:5053/udp \
  docker.pkg.github.com/richardbristow/docker-cloudflared-proxy-dns/docker-cloudflared-proxy-dns:latest
```

## Docker-compose example

```docker
docker-cloudflared-proxy-dns:
  container_name: docker-cloudflared-proxy-dns
  image: docker.pkg.github.com/richardbristow/docker-cloudflared-proxy-dns/docker-cloudflared-proxy-dns:latest
  restart: always
  ports:
    - 5053:5053/tcp
    - 5053:5053/udp
```
