FROM alpine:3.19.0 AS build

RUN apk update
RUN apk add go git bmake scdoc

WORKDIR /tmp
RUN git clone --depth 1 'https://github.com/c032/fork-tlstunnel' 'tlstunnel'

WORKDIR /tmp/tlstunnel
RUN bmake all
RUN bmake install

FROM alpine:3.19.0

COPY --from=build /usr/local/bin/tlstunnel /usr/local/bin/tlstunnel

CMD ["tlstunnel", "-config", "/etc/tlstunnel/config"]
