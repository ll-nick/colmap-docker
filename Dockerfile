FROM nvidia/cuda:11.0.3-devel-ubuntu18.04

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
    libsuitesparse-dev \
    xvfb    

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

# Remove unnecessary packages
RUN apt-get purge -y cmake && apt-get autoremove -y

# Delete source files
RUN rm -r /sources

WORKDIR /root

CMD /bin/bash
