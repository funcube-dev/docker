ARG FROM_TAG

FROM fcbuild:$FROM_TAG as fcbuild
FROM alpine:latest

RUN mkdir -p /fc/bin
COPY --from=fcbuild /go/limetx /fc/bin

COPY --from=fcbuild \
        /usr/local/lib/libLimeSuite.so \
        /usr/local/lib/libLimeSuite.so.20.01-1 \
        /usr/local/lib/libLimeSuite.so.20.01.0 \
        /usr/local/lib/

COPY --from=fcbuild \
        /usr/lib/libusb-1.0.so.0 \
        /usr/lib/libstdc++.so.6 \
        /usr/lib/libgcc_s.so.1 \
        /usr/lib/

EXPOSE 64516/tcp

WORKDIR /fc/bin
ENTRYPOINT ["/fc/bin/limetx"]
