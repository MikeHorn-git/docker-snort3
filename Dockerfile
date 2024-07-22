FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&                           \
    apt-get upgrade -y &&                       \
    apt-get install -y --no-install-recommends  \
        bison                                   \
        build-essential                         \
        ca-certificates                         \
        cmake                                   \
        libdumbnet-dev                          \
        libfl-dev                               \
        libhwloc-dev                            \
        libluajit-5.1-dev                       \
        liblzma-dev                             \
        libpcap-dev                             \
        libpcre3-dev                            \
        libssh-dev                              \
        libtool                                 \
        pkg-config                              \
        tar                                     \
        wget                                    \
        zlib1g-dev &&                           \
    apt-get clean &&                            \
    rm -rf /var/cache/apt/archives/*deb         \
        /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /snort && \
    mkdir -p /etc/snort/rules

WORKDIR /snort

ENV DAQ_VERSION 3.0.15
RUN wget -O libdaq-${DAQ_VERSION}.tar.gz -nv https://codeload.github.com/snort3/libdaq/legacy.tar.gz/refs/tags/v${DAQ_VERSION}  &&  \
    tar -xf libdaq-${DAQ_VERSION}.tar.gz &&                                                 \
    cd snort3-libdaq-1b20345 &&                                                             \
    ./bootstrap &&                                                                          \
    ./configure &&                                                                          \
    make &&                                                                                 \
    make install &&                                                                         \
    rm -rf /snort/libdaq-${DAQ_VERSION}.tar.gz                                              \
        /snort/libdaq-${DAQ_VERSION} 
 
ENV SNORT_VERSION 3.3.1.0
RUN wget -nv https://github.com/snort3/snort3/archive/refs/tags/${SNORT_VERSION}.tar.gz &&  \
    tar -xf ${SNORT_VERSION}.tar.gz &&                                                      \
    cd snort3-${SNORT_VERSION} &&                                                           \
    ./configure_cmake.sh --prefix=/snort &&                                                 \
    cd build &&                                                                             \
    make -j "$(nproc)" install &&                                                           \
    rm -rf /snort/${SNORT_VERSION}.tar.gz                                                   \
        /snort/snort3-${SNORT_VERSION} 

RUN wget -nv https://www.snort.org/downloads/community/snort3-community-rules.tar.gz &&     \
    tar -xf snort3-community-rules.tar.gz &&                                                \
    cp /snort/snort3-community-rules/snort3-community.rules /etc/snort/rules &&             \
    rm -rf /snort/snort3-community-rules.tar.gz                                             \
        /snort/snort3-community-rules 

RUN ldconfig

ENTRYPOINT ["/snort/bin/snort"]
