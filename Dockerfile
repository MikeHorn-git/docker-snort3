from debian:bookworm-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&                             \
    apt-get upgrade -y &&                         \
    apt-get install -y --no-install-recommends    \
        bison                                     \
        build-essential                           \
        ca-certificates                           \
        cmake                                     \
        libdumbnet-dev                            \
        libfl-dev                                 \
        libhwloc-dev                              \
        libluajit-5.1-dev                         \
        liblzma-dev                               \
        libpcap-dev                               \
        libpcre3-dev                              \
        libssh-dev                                \
        libtool                                   \
        pkg-config                                \
        tar                                       \
        wget                                      \
        zlib1g-dev

RUN mkdir /snort &&                               \
    mkdir -p /etc/snort/rules

WORKDIR   /snort

ENV DAQ_VERSION 3.0.14
RUN wget https://www.snort.org/downloads/snortplus/libdaq-${DAQ_VERSION}.tar.gz &&      \
    tar -xf libdaq-${DAQ_VERSION}.tar.gz &&                                             \
    cd libdaq-${DAQ_VERSION} &&                                                         \
    ./bootstrap &&                                                                      \
    ./configure &&                                                                      \
    make &&                                                                             \
    make install                                                                  

ENV SNORT_VERSION 3.1.84.0
RUN wget https://github.com/snort3/snort3/archive/refs/tags/${SNORT_VERSION}.tar.gz &&  \
    tar -xf ${SNORT_VERSION}.tar.gz &&                                                  \
    cd snort3-${SNORT_VERSION} &&                                                       \
    ./configure_cmake.sh --prefix=/snort &&                                             \
    cd build &&                                                                         \
    make -j "$(nproc)" install

RUN wget https://www.snort.org/downloads/community/snort3-community-rules.tar.gz &&     \
    tar -xf snort3-community-rules.tar.gz &&                                            \
    cp /snort/snort3-community-rules/snort3-community.rules /etc/snort/rules

RUN ldconfig

RUN apt-get clean &&                                                                    \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*                                       \
    /snort/snort3-${SNORT_VERSION}.tar.gz                                               \
    /snort/snort3-${SNORT_VERSION}                                                      \
    /snort/libdaq-${DAQ_VERSION}.tar.gz                                                 \
    /snort/libdaq-${DAQ_VERSION}                                                        \
    /snort/snort3-community-rules.tar.gz                                                \
    /snort/snort3-community-rules

ENTRYPOINT ["/snort/bin/snort"]
CMD ["-T", "-i", "${INTERFACE}"]
