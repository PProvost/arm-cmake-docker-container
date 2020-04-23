FROM ubuntu:18.04
LABEL maintainer="Peter Provost <peter.provost@microsoft.com>"
LABEL Description="Image for building AzureRTOS images using arm-none-eabi-gcc tools"

# Set up our working directory
WORKDIR /work
ADD . /work

# Pick up the basics
RUN apt-get update -y -q && \
    apt-get upgrade -y -q && \
    apt-get install -y -q \
        apt-transport-https \
        apt-utils \
        build-essential \
        bzip2 \
        ca-certificates \
        git \
        wget \
        ninja-build \
        cmake && \
    apt-get clean -y -q


# Install CMake 3.15
RUN wget --no-check-certificate https://github.com/Kitware/CMake/releases/download/v3.15.1/cmake-3.15.1-Linux-x86_64.sh \
&& chmod +x cmake-3.15.1-Linux-x86_64.sh \
&& ./cmake-3.15.1-Linux-x86_64.sh --skip-license \
&& rm -rf cmake-3.15.1-Linux-x86_64.sh

# Add the kitware APT repo and key
# RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | apt-key add - && \
#     apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main' && \
#     apt-get update -y -q && \
#     apt-get upgrade -y -q && \
#     apt-get install -y -q \
#     apt-get clean -y -q

# Get the ARM GCC build tools
RUN wget -qO- https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2 | tar -xj

ENV PATH "/work/bin:/work/gcc-arm-none-eabi-9-2019-q4-major/bin:$PATH"

# ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "/bin/bash" ]