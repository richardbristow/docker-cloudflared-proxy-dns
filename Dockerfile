FROM golang:alpine AS builder

RUN apk update && apk add --no-cache \
  build-base \
  gcc \
  git; \
  go get -v github.com/cloudflare/cloudflared/cmd/cloudflared;

FROM alpine:latest

RUN apk --no-cache add ca-certificates

COPY --from=builder /go/bin/cloudflared /bin

EXPOSE 5053/tcp
EXPOSE 5053/udp

ENTRYPOINT [ "/bin/sh", "-c" ]

CMD [ "cloudflared proxy-dns --address 0.0.0.0 --port 5053 --upstream https://1.1.1.1/dns-query --upstream https://1.0.0.1/dns-query" ]

HEALTHCHECK --interval=30s --timeout=20s --start-period=20s \
  CMD dig +short @127.0.0.1 -p 5053 cloudflare.com A || exit 1
