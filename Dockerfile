from debian:bookworm-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&                             \
    apt-get upgrade -y &&                         \
    apt-get install -y --no-install-recommends    \
        bison                                     \
        build-essential                           \
        ca-certificates                           \
        cmake                                     \
        libdaq-dev                                \
        libdumbnet-dev                            \
        libfl-dev                                 \
        libhwloc-dev                              \
        libluajit-5.1-dev                         \
        liblzma-dev                               \
        libpcre3-dev                              \
        libssh-dev                                \
        pkg-config                                \
        tcpdump                                   \
        unzip                                     \
        wget                                      \
        zlib1g-dev

RUN mkdir /snort
WORKDIR   /snort

RUN wget https://github.com/snort3/snort3/archive/refs/heads/master.zip && \
    unzip master.zip &&                                                    \
    cd snort3-master/ &&                                                   \
    export snort_path=/snort &&                                            \
    ./configure_cmake.sh --prefix="$snort_path" &&                         \
    cd build &&                                                            \
    make -j "$(nproc)" install

ENV NETWORK_INTERFACE eth0
CMD ["snort", "-T", "-i", "echo ${NETWORK_INTERFACE}", "-c", "/etc/snort/etc/snort.conf"]
