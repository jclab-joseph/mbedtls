FROM alpine:3.13

RUN uname -a && \
    apk update && \
    apk add \
    ca-certificates curl bash git \
    gcc g++ make \
    cmake python3 perl

RUN mkdir -p /work/src /work/build
ADD [ ".", "/work/src/" ]

ARG CMAKE_BUILD_TYPE=RelWithDebInfo

WORKDIR /work/src
RUN make -j4
WORKDIR /work/build
RUN cmake /work/src -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
RUN cmake --build . --config ${CMAKE_BUILD_TYPE} -- -j4

