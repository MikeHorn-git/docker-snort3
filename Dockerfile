from debian:bookworm-slim

ENV DEBIAN_FRONTEND noninteractive


RUN apt-get update &&                             \
    apt-get upgrade -y &&                         \
    apt-get install -y --no-install-recommends    \
        bison                                     \
        build-essential                           \
        cmake                                     \
        flex                                      \
        hwloc                                     \
        libdaq-dev                                \
        libdumbnet-dev                            \
        libpcre3-dev                              \
        luajit                                    \
        openssl                                   \
        pkg-config                                \
        tcpdump                                   \
        unzip                                     \
        wget                                      \
        zlib1g-dev

RUN mkdir /snort
WORKDIR   /snort

RUN wget https://github.com/snort3/snort3/archive/refs/heads/master.zip && \
    unzip main.zip &&                                                      \
    cd snort3/ &&                                                          \
    export snort_path=/snort &&                                            \
    ./configure_cmake.sh --prefix="$snort_path" &&                         \
    cd build &&                                                            \
    make -j "$(nproc)" install

ENV NETWORK_INTERFACE eth0
CMD ["snort", "-T", "-i", "echo ${NETWORK_INTERFACE}", "-c", "/etc/snort/etc/snort.conf"]
