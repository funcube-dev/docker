ARG FROM_TAG

FROM fcbuild:$FROM_TAG as fcbuild
FROM alpine:latest

RUN mkdir -p /fc/bin
COPY --from=fcbuild /go/fcwarehouse /fc/bin

EXPOSE 64518/tcp

WORKDIR /fc/bin
ENTRYPOINT ["/fc/bin/fcwarehouse"]
