FROM golang:alpine3.12 AS build

RUN apk add \
    build-base \
    musl-dev \
    dpkg \
    libsndfile-dev \
    portaudio-dev \
    libusb-dev \
    fftw-dev \
    boost-dev \
    cmake \
    py-mako \
    sqlite \
    sqlite-dev \
    swig \
    py-six \
    git

# Build limesuite
ADD LimeSuite.tar.gz /
WORKDIR /LimeSuite/builddir
RUN echo building LimeSuite && cmake ../ && make clean && make -j6 install

# Build funcube lib
ADD funcubeLib.tar.gz /
WORKDIR /funcubeLib
RUN echo building funcubelibstatic && make clean && make -j6 install

# Build golang components
ADD go.tar.gz /

# update interface wrapper for funcube lib
WORKDIR /go/fclib
RUN chmod +x . && ./update.sh

# ensure we use the vendor'd packages not download everything again...
ENV GOFLAGS -mod=vendor
ENV GOPATH /

WORKDIR /go
RUN go build ./app/limetx \
 && go build ./app/fcencode \
 && go build ./app/fcdecode \
 && go build ./app/fcwarehouse

