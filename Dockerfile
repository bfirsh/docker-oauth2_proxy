FROM alpine:3.4

ENV OAUTH2_PROXY_VERSION=2.1.linux-amd64.go1.6

RUN apk add --no-cache ca-certificates
RUN apk add --no-cache --virtual .fetch-deps \
    openssl \
    tar \
  && wget -O /oauth2_proxy.tar.gz https://github.com/bitly/oauth2_proxy/releases/download/v2.1/oauth2_proxy-$OAUTH2_PROXY_VERSION.tar.gz \
  && tar -xvzf /oauth2_proxy.tar.gz --strip-components=1 \
  && rm /oauth2_proxy.tar.gz \
  && apk del .fetch-deps

EXPOSE 4180
ENTRYPOINT ["/oauth2_proxy", "--http-address=0.0.0.0:4180"]
