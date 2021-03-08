FROM nvidia/cudagl:11.2.0-base

# To suppress user input during tzdata installation
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    cmake \
    git \
    build-essential \
    libboost-program-options-dev \
    libboost-filesystem-dev \
    libboost-graph-dev \
    libboost-regex-dev \
    libboost-system-dev \
    libboost-test-dev \
    libeigen3-dev \
    libsuitesparse-dev \
    libfreeimage-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    libglew-dev \
    qtbase5-dev \
    libqt5opengl5-dev \
    libcgal-dev \
    libatlas-base-dev \
    libsuitesparse-dev

RUN mkdir /sources
RUN git clone https://ceres-solver.googlesource.com/ceres-solver "/sources/ceres-solver" \
&&  git clone https://github.com/ll-nick/colmap.git "/sources/colmap"

# Install Ceres Solver
RUN mkdir -p /sources/ceres-solver/build
WORKDIR /sources/ceres-solver/build
RUN cmake .. -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF && make && make install && make clean 

# Install Colmap
RUN mkdir -p /sources/colmap/build
WORKDIR /sources/colmap/build
RUN cmake .. -DCMAKE_BUILD_TYPE=Release -DTESTS_ENABLED=OFF && make && make install && make clean

# Delete GUI executable
# RUN rm /usr/local/bin/colmap

# Remove unnecessary packages
RUN apt-get purge -y cmake && apt-get autoremove -y

# Delete source files
RUN rm -r /sources

WORKDIR /root

ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics
ENV QT_QPA_PLATFORM offscreen

CMD /bin/bash
