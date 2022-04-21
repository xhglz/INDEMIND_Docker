FROM osrf/ros:melodic-desktop-full

USER root
ENV DEBIAN_FRONTEND noninteractive
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV HOME=/root SHELL=/bin/bash

RUN apt-get update && apt-get install -y build-essential cmake gcc g++ clang
RUN apt-get install -y python3-dev python3-matplotlib python3-numpy python3-psutil python3-tk python-catkin-tools
RUN apt-get install -y libgoogle-glog-dev libgflags-dev libatlas-base-dev libeigen3-dev libsuitesparse-dev libceres-dev
RUN apt-get install -y libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
RUN apt-get install -y libglfw3-dev libusb-1.0-0-dev git 

COPY ${PWD}/thirdparty/opencv /root/opencv
WORKDIR /root/opencv
ENV OPENCV_VERSION="3.4.3"
RUN git checkout tags/${OPENCV_VERSION} && \
    mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=RELEASE \
          -DCMAKE_INSTALL_PREFIX=/usr/local \
          -DWITH_CUDA=OFF \
          -DBUILD_DOCS=OFF \
          -DBUILD_EXAMPLES=OFF \
          -DBUILD_TESTS=OFF \
          -DBUILD_PERF_TESTS=OFF .. && \
    make -j$(nproc) && make install

RUN apt-get install -y autoconf automake libtool
COPY ${PWD}/thirdparty/protobuf /root/protobuf
WORKDIR /root/protobuf
RUN ./autogen.sh && \
    ./configure && \
    make -j$(nproc) && make check && make install

COPY ${PWD}/thirdparty/MNN /root/MNN
WORKDIR /root/MNN
RUN ./schema/generate.sh && \
    mkdir build && cd build && \
    cmake .. && make -j$(nproc) && make install 

RUN apt-get clean
RUN rm -rf /root/opencv /root/protobuf /root/MNN
RUN ( \
    echo 'source /root/IMSEE-SDK/ros/devel/setup.bash'; \
  ) > /root/.bashrc