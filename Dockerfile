FROM golang:1.18.3-alpine AS builder

RUN apk add --update --no-cache \
  build-base \
  git \
  && git clone https://github.com/cloudflare/cloudflared.git \
  && cd cloudflared \
  && make cloudflared \
  && go install github.com/cloudflare/cloudflared/cmd/cloudflared

FROM alpine:3.16.0

RUN apk add --update --no-cache \
  ca-certificates \
  bind-tools

COPY --from=builder /go/bin/cloudflared /bin

EXPOSE 5053/tcp
EXPOSE 5053/udp

ENTRYPOINT [ "cloudflared", "proxy-dns" ]

CMD [ "--address", "0.0.0.0", "--port", "5053", "--upstream", "https://1.1.1.1/dns-query", "--upstream", "https://1.0.0.1/dns-query" ]

HEALTHCHECK --interval=30s --timeout=20s --start-period=20s \
  CMD dig +short @127.0.0.1 -p 5053 cloudflare.com AAAA || exit 1
