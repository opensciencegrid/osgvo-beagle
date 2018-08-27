FROM opensciencegrid/osgvo-ubuntu-xenial

RUN apt-get update -y && \
    apt-get remove -y openjdk-* && \
    apt-get install -y \
        build-essential \
        autoconf \
        automake \
        libtool \
        git \
        pkg-config \
        openjdk-9-jdk-headless \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# see https://github.com/beagle-dev/beagle-lib/wiki/LinuxInstallInstructions
RUN cd /tmp && \
    rm -rf beagle-lib && \
    git clone --depth=1 https://github.com/beagle-dev/beagle-lib.git && \
    cd beagle-lib && \
    ./autogen.sh && \
    ./configure --prefix=/opt/beagle && \
    make install && \
    cd .. && \
    rm -rf beagle-lib

# build info
RUN echo "Timestamp:" `date --utc` | tee /image-build-info.txt

