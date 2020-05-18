ARG FROM_TAG

FROM fcbuild:$FROM_TAG as fcbuild
FROM alpine:latest

RUN mkdir -p /fc/bin
COPY --from=fcbuild /go/fcencode /fc/bin
COPY --from=fcbuild \
    /usr/lib/libfftw3f.so.3 \
    /usr/lib/libusb-1.0.so.0 \
    /usr/lib/libportaudio.so.2 \
    /usr/lib/libsndfile.so.1 \
    /usr/lib/libstdc++.so.6 \
    /usr/lib/libgcc_s.so.1 \
    /usr/lib/libasound.so.2 \
    /usr/lib/libjack.so.0 \
    /usr/lib/libFLAC.so.8 \
    /usr/lib/libogg.so.0 \
    /usr/lib/libvorbis.so.0 \
    /usr/lib/libvorbisenc.so.2 \
    /usr/lib/

COPY --from=fcbuild /usr/share/alsa/alsa.conf /usr/share/alsa/alsa.conf

EXPOSE 64514/tcp

WORKDIR /fc/bin
ENTRYPOINT ["/fc/bin/fcencode"]
