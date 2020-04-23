FROM ubuntu:18.04
LABEL maintainer="Peter Provost <peter.provost@microsoft.com>"
LABEL Description="Image for building AzureRTOS images using arm-none-eabi-gcc tools"

# Set up our working directory
WORKDIR /work
ADD . /work

# Pick up the basics
RUN apt update -y && \
    apt upgrade -y && \
    apt install -y \
        build-essential \
        git \
        bzip2 \
        wget && \
    apt clean

# Add the kitware APT repo and key
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | apt-key add -
RUN apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main'

RUN apt update -y && \
    apt upgrade -y && \
    apt install -y \
        ninja-build \
        cmake

# Get the ARM GCC build tools
RUN wget -qO- https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2 | tar -xj

ENV PATH "/work/gcc-arm-none-eabi-9-2019-q4-major/bin:$PATH"

ENTRYPOINT [ "/entrypoint.sh" ]